using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;
using Yarn.Markup;

namespace Yarn.Unity;

[AddComponentMenu("Scripts/Yarn Spinner/Dialogue Runner")]
[HelpURL("https://yarnspinner.dev/docs/unity/components/dialogue-runner/")]
public class DialogueRunner : MonoBehaviour, IActionRegistration
{
	[Serializable]
	public class StringUnityEvent : UnityEvent<string>
	{
	}

	[Serializable]
	private struct SaveData
	{
		public string[] floatKeys;

		public float[] floatValues;

		public string[] stringKeys;

		public string[] stringValues;

		public string[] boolKeys;

		public bool[] boolValues;
	}

	[Serializable]
	[CompilerGenerated]
	private sealed class _003C_003Ec
	{
		public static readonly _003C_003Ec _003C_003E9 = new _003C_003Ec();

		public static Logger _003C_003E9__98_1;

		internal void _003CCreateDialogueInstance_003Eb__98_1(string message)
		{
			Debug.LogError(message);
		}
	}

	[FormerlySerializedAs("yarnProgram")]
	public YarnProject yarnProject;

	[FormerlySerializedAs("variableStorage")]
	[SerializeField]
	internal VariableStorageBehaviour _variableStorage;

	public DialogueViewBase[] dialogueViews = new DialogueViewBase[0];

	public string startNode = "Start";

	public bool startAutomatically = true;

	public bool runSelectedOptionAsLine;

	public LineProviderBehaviour lineProvider;

	[Tooltip("If true, will print Debug.Log messages every time it enters a node, and other frequent events")]
	public bool verboseLogging = true;

	public StringUnityEvent onNodeStart;

	public StringUnityEvent onNodeComplete;

	public UnityEvent onDialogueStart;

	public UnityEvent onDialogueComplete;

	public StringUnityEvent onCommand;

	private bool IsOptionSelectionAllowed;

	private ICommandDispatcher commandDispatcher;

	private readonly HashSet<DialogueViewBase> ActiveDialogueViews = new HashSet<DialogueViewBase>();

	public Action<int> onSelectAction;

	private Action<int> selectAction;

	private Dialogue _dialogue;

	private OptionSet currentOptions;

	public VariableStorageBehaviour VariableStorage
	{
		get
		{
			return _variableStorage;
		}
		set
		{
			_variableStorage = value;
			if (_dialogue != null)
			{
				_dialogue.VariableStorage = (IVariableStorage)(object)value;
			}
		}
	}

	public bool IsDialogueRunning { get; private set; }

	public string CurrentNodeName => Dialogue.CurrentNode;

	public Dialogue Dialogue => _dialogue ?? (_dialogue = CreateDialogueInstance());

	internal ICommandDispatcher CommandDispatcher
	{
		get
		{
			if (commandDispatcher == null)
			{
				((Actions)(commandDispatcher = new Actions(this, Dialogue.Library))).RegisterActions();
			}
			return commandDispatcher;
		}
	}

	internal LocalizedLine CurrentLine { get; private set; }

	public void SetProject(YarnProject newProject)
	{
		yarnProject = newProject;
		CommandDispatcher.SetupForProject(newProject);
		Dialogue.SetProgram(newProject.Program);
		if (lineProvider != null)
		{
			lineProvider.YarnProject = newProject;
		}
		SetInitialVariables();
	}

	public void SetInitialVariables(bool overrideExistingValues = false)
	{
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Expected I4, but got Unknown
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		if (yarnProject == null)
		{
			Debug.LogError("Unable to set default values, there is no project set");
			return;
		}
		foreach (KeyValuePair<string, Operand> initialValue in yarnProject.Program.InitialValues)
		{
			if (overrideExistingValues || !VariableStorage.Contains(initialValue.Key))
			{
				Operand value = initialValue.Value;
				ValueOneofCase valueCase = value.ValueCase;
				switch (valueCase - 1)
				{
				case 0:
					VariableStorage.SetValue(initialValue.Key, value.StringValue);
					break;
				case 1:
					VariableStorage.SetValue(initialValue.Key, value.BoolValue);
					break;
				case 2:
					VariableStorage.SetValue(initialValue.Key, value.FloatValue);
					break;
				default:
					Debug.LogWarning($"{initialValue.Key} is of an invalid type: {value.ValueCase}");
					break;
				}
			}
		}
	}

	public void StartDialogue(string startNode)
	{
		if (Dialogue.IsActive)
		{
			Debug.LogError("Can't start dialogue from node " + startNode + ": the dialogue is currently in the middle of running. Stop the dialogue first.");
			return;
		}
		if (!yarnProject.NodeNames.Contains(startNode))
		{
			Debug.Log("Can't start dialogue from node " + startNode + ": the Yarn Project " + yarnProject.name + " does not contain a node named \"" + startNode + "\"", yarnProject);
			return;
		}
		DialogueViewBase[] array = dialogueViews;
		foreach (DialogueViewBase dialogueViewBase in array)
		{
			if (!(dialogueViewBase == null) && dialogueViewBase.isActiveAndEnabled)
			{
				dialogueViewBase.StopAllCoroutines();
			}
		}
		IsDialogueRunning = true;
		onDialogueStart.Invoke();
		array = dialogueViews;
		foreach (DialogueViewBase dialogueViewBase2 in array)
		{
			if (!(dialogueViewBase2 == null) && dialogueViewBase2.isActiveAndEnabled)
			{
				dialogueViewBase2.DialogueStarted();
			}
		}
		Dialogue.SetNode(startNode);
		if (!lineProvider.LinesAvailable)
		{
			StartCoroutine(ContinueDialogueWhenLinesAvailable());
		}
		else
		{
			ContinueDialogue();
		}
	}

	private IEnumerator ContinueDialogueWhenLinesAvailable()
	{
		while (!lineProvider.LinesAvailable)
		{
			yield return null;
		}
		ContinueDialogue();
	}

	public void Clear()
	{
		Dialogue.UnloadAll();
	}

	public void Stop()
	{
		IsDialogueRunning = false;
		Dialogue.Stop();
	}

	public bool NodeExists(string nodeName)
	{
		return Dialogue.NodeExists(nodeName);
	}

	public IEnumerable<string> GetTagsForNode(string nodeName)
	{
		return Dialogue.GetTagsForNode(nodeName);
	}

	public void AddCommandHandler(string commandName, Delegate handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler(string commandName, MethodInfo method)
	{
		CommandDispatcher.AddCommandHandler(commandName, method);
	}

	public void AddCommandHandler(string commandName, Func<Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1>(string commandName, Func<T1, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, Coroutine> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler(string commandName, Func<IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1>(string commandName, Func<T1, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Func<T1, T2, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Func<T1, T2, T3, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Func<T1, T2, T3, T4, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Func<T1, T2, T3, T4, T5, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Func<T1, T2, T3, T4, T5, T6, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, IEnumerator> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler(string commandName, Action handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1>(string commandName, Action<T1> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2>(string commandName, Action<T1, T2> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3>(string commandName, Action<T1, T2, T3> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4>(string commandName, Action<T1, T2, T3, T4> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5>(string commandName, Action<T1, T2, T3, T4, T5> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6>(string commandName, Action<T1, T2, T3, T4, T5, T6> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void AddCommandHandler<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(string commandName, Action<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> handler)
	{
		CommandDispatcher.AddCommandHandler(commandName, handler);
	}

	public void RemoveCommandHandler(string commandName)
	{
		CommandDispatcher.RemoveCommandHandler(commandName);
	}

	public void AddFunction(string name, Delegate implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<TResult>(string name, Func<TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, TResult>(string name, Func<T1, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, TResult>(string name, Func<T1, T2, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, TResult>(string name, Func<T1, T2, T3, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, TResult>(string name, Func<T1, T2, T3, T4, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, TResult>(string name, Func<T1, T2, T3, T4, T5, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void AddFunction<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult>(string name, Func<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, TResult> implementation)
	{
		CommandDispatcher.AddFunction(name, implementation);
	}

	public void RemoveFunction(string name)
	{
		CommandDispatcher.RemoveFunction(name);
	}

	public void SetDialogueViews(DialogueViewBase[] views)
	{
		foreach (DialogueViewBase dialogueViewBase in views)
		{
			if (!(dialogueViewBase == null))
			{
				dialogueViewBase.requestInterrupt = OnViewRequestedInterrupt;
			}
		}
		dialogueViews = views;
	}

	private void Awake()
	{
		if (dialogueViews.Length == 0)
		{
			Debug.LogWarning("Dialogue Runner doesn't have any dialogue views set up. No lines or options will be visible.");
		}
		DialogueViewBase[] array = dialogueViews;
		foreach (DialogueViewBase dialogueViewBase in array)
		{
			if (!(dialogueViewBase == null))
			{
				dialogueViewBase.requestInterrupt = OnViewRequestedInterrupt;
			}
		}
		if (yarnProject != null)
		{
			if (Dialogue.IsActive)
			{
				Debug.LogError("DialogueRunner wanted to load a Yarn Project in its Start method, but the Dialogue was already running one. The Dialogue Runner may not behave as you expect.");
			}
			SetProject(yarnProject);
		}
		if (!(lineProvider == null))
		{
			return;
		}
		if (yarnProject == null || yarnProject.localizationType == LocalizationType.YarnInternal)
		{
			lineProvider = base.gameObject.AddComponent<TextLineProvider>();
			lineProvider.YarnProject = yarnProject;
			if (verboseLogging)
			{
				Debug.Log("Dialogue Runner has no LineProvider; creating a TextLineProvider.", this);
			}
		}
		else
		{
			Debug.LogError("The Yarn Project \"" + yarnProject.name + "\" uses the Unity Localization system, but the Unity Localization system is not currently installed. Please install it.");
		}
	}

	private void Start()
	{
		if (yarnProject != null && startAutomatically)
		{
			StartDialogue(startNode);
		}
	}

	private Dialogue CreateDialogueInstance()
	{
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Expected O, but got Unknown
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Expected O, but got Unknown
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Expected O, but got Unknown
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00aa: Expected O, but got Unknown
		//IL_00aa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Expected O, but got Unknown
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ce: Expected O, but got Unknown
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Expected O, but got Unknown
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Expected O, but got Unknown
		//IL_0105: Expected O, but got Unknown
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Expected O, but got Unknown
		if (VariableStorage == null)
		{
			VariableStorage = base.gameObject.AddComponent<InMemoryVariableStorage>();
			if (verboseLogging)
			{
				Debug.Log("Dialogue Runner has no Variable Storage; creating a InMemoryVariableStorage", this);
			}
		}
		Dialogue val = new Dialogue((IVariableStorage)(object)VariableStorage)
		{
			LogDebugMessage = (Logger)delegate(string message)
			{
				if (verboseLogging)
				{
					Debug.Log(message);
				}
			}
		};
		object obj = _003C_003Ec._003C_003E9__98_1;
		if (obj == null)
		{
			Logger val2 = delegate(string message)
			{
				Debug.LogError(message);
			};
			_003C_003Ec._003C_003E9__98_1 = val2;
			obj = (object)val2;
		}
		val.LogErrorMessage = (Logger)obj;
		val.LineHandler = new LineHandler(HandleLine);
		val.CommandHandler = new CommandHandler(HandleCommand);
		val.OptionsHandler = new OptionsHandler(HandleOptions);
		val.NodeStartHandler = (NodeStartHandler)delegate(string node)
		{
			onNodeStart?.Invoke(node);
		};
		val.NodeCompleteHandler = (NodeCompleteHandler)delegate(string node)
		{
			onNodeComplete?.Invoke(node);
		};
		val.DialogueCompleteHandler = new DialogueCompleteHandler(HandleDialogueComplete);
		val.PrepareForLinesHandler = new PrepareForLinesHandler(PrepareForLines);
		selectAction = SelectedOption;
		return val;
	}

	internal void HandleOptions(OptionSet options)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (lineProvider.LinesAvailable)
		{
			HandleOptionsInternal();
		}
		else
		{
			StartCoroutine(WaitUntilLinesAvailable());
		}
		void HandleOptionsInternal()
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000c: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b4: Expected O, but got Unknown
			//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
			//IL_010f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0047: Unknown result type (might be due to invalid IL or missing references)
			//IL_0069: Unknown result type (might be due to invalid IL or missing references)
			//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
			currentOptions = options;
			DialogueOption[] array = new DialogueOption[((OptionSet)(ref options)).Options.Length];
			for (int i = 0; i < ((OptionSet)(ref options)).Options.Length; i++)
			{
				LocalizedLine localizedLine = lineProvider.GetLocalizedLine(((Option)(ref ((OptionSet)(ref options)).Options[i])).Line);
				string text = Dialogue.ExpandSubstitutions(localizedLine.RawText, (IList<string>)((Option)(ref ((OptionSet)(ref options)).Options[i])).Line.Substitutions);
				Dialogue.LanguageCode = lineProvider.LocaleCode;
				try
				{
					localizedLine.Text = Dialogue.ParseMarkup(text);
				}
				catch (MarkupParseException ex)
				{
					MarkupParseException ex2 = ex;
					Debug.LogWarning("Failed to parse markup in \"" + text + "\": " + ((Exception)(object)ex2).Message);
					localizedLine.Text = new MarkupParseResult
					{
						Text = text,
						Attributes = new List<MarkupAttribute>()
					};
				}
				array[i] = new DialogueOption
				{
					TextID = ((Option)(ref ((OptionSet)(ref options)).Options[i])).Line.ID,
					DialogueOptionID = ((Option)(ref ((OptionSet)(ref options)).Options[i])).ID,
					Line = localizedLine,
					IsAvailable = ((Option)(ref ((OptionSet)(ref options)).Options[i])).IsAvailable
				};
			}
			IsOptionSelectionAllowed = false;
			DialogueViewBase[] array2 = dialogueViews;
			foreach (DialogueViewBase dialogueViewBase in array2)
			{
				if (!(dialogueViewBase == null) && dialogueViewBase.isActiveAndEnabled)
				{
					dialogueViewBase.RunOptions(array, selectAction);
				}
			}
			IsOptionSelectionAllowed = true;
		}
		IEnumerator WaitUntilLinesAvailable()
		{
			while (!lineProvider.LinesAvailable)
			{
				yield return null;
			}
			HandleOptionsInternal();
		}
	}

	private void HandleDialogueComplete()
	{
		IsDialogueRunning = false;
		DialogueViewBase[] array = dialogueViews;
		foreach (DialogueViewBase dialogueViewBase in array)
		{
			if (!(dialogueViewBase == null) && dialogueViewBase.isActiveAndEnabled)
			{
				dialogueViewBase.DialogueComplete();
			}
		}
		onDialogueComplete.Invoke();
	}

	internal void HandleCommand(Command command)
	{
		CommandDispatchResult commandDispatchResult = CommandDispatcher.DispatchCommand(((Command)(ref command)).Text, out var commandCoroutine);
		switch (commandDispatchResult.Status)
		{
		case CommandDispatchResult.StatusType.SucceededSync:
			ContinueDialogue();
			return;
		case CommandDispatchResult.StatusType.SucceededAsync:
			StartCoroutine(WaitForYieldInstruction(commandCoroutine, delegate
			{
				ContinueDialogue(dontRestart: true);
			}));
			return;
		}
		IEnumerable<string> source = SplitCommandText(((Command)(ref command)).Text);
		string text = source.ElementAtOrDefault(0);
		switch (commandDispatchResult.Status)
		{
		case CommandDispatchResult.StatusType.NoTargetFound:
			Debug.LogError("Can't call command " + text + ": failed to find a game object named " + source.ElementAtOrDefault(1), this);
			break;
		case CommandDispatchResult.StatusType.TargetMissingComponent:
			Debug.LogError("Can't call command " + text + ", because " + source.ElementAtOrDefault(1) + " doesn't have the correct component");
			break;
		case CommandDispatchResult.StatusType.InvalidParameterCount:
			Debug.LogError("Can't call command " + text + ": incorrect number of parameters");
			break;
		case CommandDispatchResult.StatusType.CommandUnknown:
			if (onCommand != null && onCommand.GetPersistentEventCount() > 0)
			{
				onCommand.Invoke(((Command)(ref command)).Text);
			}
			else
			{
				Debug.LogError("No Command \"" + text + "\" was found. Did you remember to use the YarnCommand attribute or AddCommandHandler() function in C#?");
			}
			return;
		default:
			throw new ArgumentOutOfRangeException($"Internal error: Unknown command dispatch result status {commandDispatchResult}");
		}
		ContinueDialogue();
	}

	internal void HandleLine(Line line)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		if (lineProvider.LinesAvailable)
		{
			HandleLineInternal();
		}
		else
		{
			StartCoroutine(WaitUntilLinesAvailable());
		}
		void HandleLineInternal()
		{
			//IL_0012: Unknown result type (might be due to invalid IL or missing references)
			//IL_0103: Expected O, but got Unknown
			//IL_012b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0145: Unknown result type (might be due to invalid IL or missing references)
			//IL_00f6: Unknown result type (might be due to invalid IL or missing references)
			CurrentLine = lineProvider.GetLocalizedLine(line);
			string text = Dialogue.ExpandSubstitutions(CurrentLine.RawText, (IList<string>)CurrentLine.Substitutions);
			if (text == null)
			{
				Debug.LogWarning("Dialogue Runner couldn't expand substitutions in Yarn Project [" + yarnProject.name + "] node [" + CurrentNodeName + "] with line ID [" + CurrentLine.TextID + "]. This usually happens because it couldn't find text in the Localization. The line may not be tagged properly. Try re-importing this Yarn Program. For now, Dialogue Runner will swap in CurrentLine.RawText.");
				text = CurrentLine.RawText;
			}
			Dialogue.LanguageCode = lineProvider.LocaleCode;
			try
			{
				CurrentLine.Text = Dialogue.ParseMarkup(text);
			}
			catch (MarkupParseException ex)
			{
				MarkupParseException ex2 = ex;
				Debug.LogWarning("Failed to parse markup in \"" + text + "\": " + ((Exception)(object)ex2).Message);
				CurrentLine.Text = new MarkupParseResult
				{
					Text = text,
					Attributes = new List<MarkupAttribute>()
				};
			}
			ActiveDialogueViews.Clear();
			DialogueViewBase[] array = dialogueViews;
			foreach (DialogueViewBase dialogueViewBase in array)
			{
				if (!(dialogueViewBase == null) && dialogueViewBase.isActiveAndEnabled)
				{
					ActiveDialogueViews.Add(dialogueViewBase);
				}
			}
			array = dialogueViews;
			foreach (DialogueViewBase dialogueView in array)
			{
				if (!(dialogueView == null) && dialogueView.isActiveAndEnabled)
				{
					dialogueView.RunLine(CurrentLine, delegate
					{
						DialogueViewCompletedDelivery(dialogueView);
					});
				}
			}
		}
		IEnumerator WaitUntilLinesAvailable()
		{
			while (!lineProvider.LinesAvailable)
			{
				yield return null;
			}
			HandleLineInternal();
		}
	}

	private void InterruptLine()
	{
		ActiveDialogueViews.Clear();
		DialogueViewBase[] array = dialogueViews;
		foreach (DialogueViewBase dialogueViewBase in array)
		{
			if (!(dialogueViewBase == null) && dialogueViewBase.isActiveAndEnabled)
			{
				ActiveDialogueViews.Add(dialogueViewBase);
			}
		}
		array = dialogueViews;
		foreach (DialogueViewBase dialogueView in array)
		{
			dialogueView.InterruptLine(CurrentLine, delegate
			{
				DialogueViewCompletedInterrupt(dialogueView);
			});
		}
	}

	private void SelectedOption(int optionIndex)
	{
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		if (!IsOptionSelectionAllowed)
		{
			throw new InvalidOperationException("Selecting an option on the same frame that options are provided is not allowed. Wait at least one frame before selecting an option.");
		}
		Dialogue.SetSelectedOption(optionIndex);
		if (onSelectAction != null)
		{
			onSelectAction(optionIndex);
		}
		if (runSelectedOptionAsLine)
		{
			Option[] options = ((OptionSet)(ref currentOptions)).Options;
			for (int i = 0; i < options.Length; i++)
			{
				Option val = options[i];
				if (((Option)(ref val)).ID == optionIndex)
				{
					HandleLine(((Option)(ref val)).Line);
					return;
				}
			}
			Debug.LogError(string.Format("Can't run selected option ({0}) as a line: couldn't find the option's associated {1} object", optionIndex, "Line"));
			ContinueDialogue();
		}
		else
		{
			ContinueDialogue();
		}
	}

	private static IEnumerator WaitForYieldInstruction(YieldInstruction yieldInstruction, Action onSuccessfulDispatch)
	{
		yield return yieldInstruction;
		onSuccessfulDispatch();
	}

	private void PrepareForLines(IEnumerable<string> lineIDs)
	{
		lineProvider.PrepareForLines(lineIDs);
	}

	private void DialogueViewCompletedDelivery(DialogueViewBase dialogueView)
	{
		ActiveDialogueViews.Remove(dialogueView);
		if (ActiveDialogueViews.Count == 0)
		{
			DismissLineFromViews(dialogueViews);
		}
	}

	private void DialogueViewCompletedInterrupt(DialogueViewBase dialogueView)
	{
		ActiveDialogueViews.Remove(dialogueView);
		if (ActiveDialogueViews.Count == 0)
		{
			DismissLineFromViews(dialogueViews);
		}
	}

	private void ContinueDialogue(bool dontRestart = false)
	{
		if (!dontRestart || Dialogue.IsActive)
		{
			CurrentLine = null;
			Dialogue.Continue();
		}
	}

	public void OnViewRequestedInterrupt()
	{
		if (CurrentLine == null)
		{
			Debug.LogWarning("Dialogue runner was asked to advance but there is no current line");
		}
		else if (ActiveDialogueViews.Count == 0)
		{
			Debug.Log("user requested advance, all views finished, ignoring interrupt");
		}
		else
		{
			InterruptLine();
		}
	}

	private void DismissLineFromViews(IEnumerable<DialogueViewBase> dialogueViews)
	{
		ActiveDialogueViews.Clear();
		foreach (DialogueViewBase dialogueView2 in dialogueViews)
		{
			if (!(dialogueView2 == null) && dialogueView2.isActiveAndEnabled)
			{
				ActiveDialogueViews.Add(dialogueView2);
			}
		}
		foreach (DialogueViewBase dialogueView in dialogueViews)
		{
			if (!(dialogueView == null) && dialogueView.isActiveAndEnabled)
			{
				dialogueView.DismissLine(delegate
				{
					DialogueViewCompletedDismissal(dialogueView);
				});
			}
		}
	}

	private void DialogueViewCompletedDismissal(DialogueViewBase dialogueView)
	{
		ActiveDialogueViews.Remove(dialogueView);
		if (ActiveDialogueViews.Count == 0)
		{
			ContinueDialogue();
		}
	}

	public static IEnumerable<string> SplitCommandText(string input)
	{
		StringReader stringReader = new StringReader(input.Normalize());
		List<string> list = new List<string>();
		StringBuilder stringBuilder = new StringBuilder();
		int num;
		while ((num = stringReader.Read()) != -1)
		{
			if (char.IsWhiteSpace((char)num))
			{
				if (stringBuilder.Length > 0)
				{
					list.Add(stringBuilder.ToString());
					stringBuilder.Clear();
				}
			}
			else if (num == 34)
			{
				while (true)
				{
					num = stringReader.Read();
					switch (num)
					{
					case -1:
						list.Add(stringBuilder.ToString());
						return list;
					case 92:
					{
						int num2 = stringReader.Peek();
						if (num2 == 92 || num2 == 34)
						{
							stringReader.Read();
							stringBuilder.Append((char)num2);
						}
						else
						{
							stringBuilder.Append((char)num);
						}
						continue;
					}
					default:
						stringBuilder.Append((char)num);
						continue;
					case 34:
						break;
					}
					break;
				}
				list.Add(stringBuilder.ToString());
				stringBuilder.Clear();
			}
			else
			{
				stringBuilder.Append((char)num);
			}
		}
		if (stringBuilder.Length > 0)
		{
			list.Add(stringBuilder.ToString());
		}
		return list;
	}

	[Obsolete("LoadStateFromPlayerPrefs is deprecated, please use LoadStateFromPersistentStorage instead.")]
	public bool LoadStateFromPlayerPrefs(string SaveKey = "YarnBasicSave")
	{
		if (PlayerPrefs.HasKey(SaveKey))
		{
			string jsonData = PlayerPrefs.GetString(SaveKey);
			try
			{
				(Dictionary<string, float>, Dictionary<string, string>, Dictionary<string, bool>) tuple = DeserializeAllVariablesFromJSON(jsonData);
				_variableStorage.SetAllVariables(tuple.Item1, tuple.Item2, tuple.Item3);
				return true;
			}
			catch (ArgumentException ex)
			{
				Debug.LogWarning("Unable to load saved data: " + ex.Message);
				return false;
			}
		}
		Debug.LogWarning("Attempted to load the runner previous state but found none saved");
		return false;
	}

	public bool LoadStateFromPersistentStorage(string saveFileName)
	{
		string text = Path.Combine(Application.persistentDataPath, saveFileName);
		try
		{
			string jsonData = File.ReadAllText(text);
			(Dictionary<string, float>, Dictionary<string, string>, Dictionary<string, bool>) tuple = DeserializeAllVariablesFromJSON(jsonData);
			_variableStorage.SetAllVariables(tuple.Item1, tuple.Item2, tuple.Item3);
		}
		catch (Exception ex)
		{
			Debug.LogError("Failed to load save state at " + text + ": " + ex.Message);
			return false;
		}
		return true;
	}

	[Obsolete("SaveStateToPlayerPrefs is deprecated, please use SaveStateToPersistentStorage instead.")]
	public void SaveStateToPlayerPrefs(string SaveKey = "YarnBasicSave")
	{
		string value = SerializeAllVariablesToJSON();
		PlayerPrefs.SetString(SaveKey, value);
		PlayerPrefs.Save();
	}

	public bool SaveStateToPersistentStorage(string saveFileName)
	{
		string contents = SerializeAllVariablesToJSON();
		string text = Path.Combine(Application.persistentDataPath, saveFileName);
		try
		{
			File.WriteAllText(text, contents);
			return true;
		}
		catch (Exception ex)
		{
			Debug.LogError("Failed to save state to " + text + ": " + ex.Message);
			return false;
		}
	}

	private (Dictionary<string, float>, Dictionary<string, string>, Dictionary<string, bool>) DeserializeAllVariablesFromJSON(string jsonData)
	{
		SaveData saveData = JsonUtility.FromJson<SaveData>(jsonData);
		if (saveData.floatKeys == null && saveData.floatValues == null)
		{
			throw new ArgumentException("Provided JSON string was not able to extract numeric variables");
		}
		if (saveData.stringKeys == null && saveData.stringValues == null)
		{
			throw new ArgumentException("Provided JSON string was not able to extract string variables");
		}
		if (saveData.boolKeys == null && saveData.boolValues == null)
		{
			throw new ArgumentException("Provided JSON string was not able to extract boolean variables");
		}
		if (saveData.floatKeys.Length != saveData.floatValues.Length)
		{
			throw new ArgumentException("Number of keys and values of numeric variables does not match");
		}
		if (saveData.stringKeys.Length != saveData.stringValues.Length)
		{
			throw new ArgumentException("Number of keys and values of string variables does not match");
		}
		if (saveData.boolKeys.Length != saveData.boolValues.Length)
		{
			throw new ArgumentException("Number of keys and values of boolean variables does not match");
		}
		Dictionary<string, float> dictionary = new Dictionary<string, float>();
		for (int i = 0; i < saveData.floatValues.Length; i++)
		{
			dictionary.Add(saveData.floatKeys[i], saveData.floatValues[i]);
		}
		Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
		for (int j = 0; j < saveData.stringValues.Length; j++)
		{
			dictionary2.Add(saveData.stringKeys[j], saveData.stringValues[j]);
		}
		Dictionary<string, bool> dictionary3 = new Dictionary<string, bool>();
		for (int k = 0; k < saveData.boolValues.Length; k++)
		{
			dictionary3.Add(saveData.boolKeys[k], saveData.boolValues[k]);
		}
		return (dictionary, dictionary2, dictionary3);
	}

	private string SerializeAllVariablesToJSON()
	{
		var (dictionary, dictionary2, dictionary3) = _variableStorage.GetAllVariables();
		return JsonUtility.ToJson((object)new SaveData
		{
			floatKeys = dictionary.Keys.ToArray(),
			floatValues = dictionary.Values.ToArray(),
			stringKeys = dictionary2.Keys.ToArray(),
			stringValues = dictionary2.Values.ToArray(),
			boolKeys = dictionary3.Keys.ToArray(),
			boolValues = dictionary3.Values.ToArray()
		}, true);
	}
}
