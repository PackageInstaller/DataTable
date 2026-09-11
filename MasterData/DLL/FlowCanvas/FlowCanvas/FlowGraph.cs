using System;
using System.Collections.Generic;
using FlowCanvas.Macros;
using NodeCanvas.Framework;
using ParadoxNotion;
using UnityEngine;

namespace FlowCanvas;

[Serializable]
[GraphInfo(packageName = "FlowCanvas", docsURL = "http://flowcanvas.paradoxnotion.com/documentation/", resourcesURL = "http://flowcanvas.paradoxnotion.com/downloads/", forumsURL = "http://flowcanvas.paradoxnotion.com/forums-page/")]
public abstract class FlowGraph : Graph
{
	private bool hasBinded;

	private bool hasInitialized;

	private List<IUpdatable> updatableNodes;

	private List<IRenderCreateHPTips> createHPTipsNodes;

	private Dictionary<string, IInvokable> functions;

	private Dictionary<Type, Component> cachedAgentComponents;

	public override Type baseNodeType => typeof(FlowNode);

	public override bool useLocalBlackboard => false;

	public override bool requiresAgent => false;

	public override bool requiresPrimeNode => false;

	public override bool autoSort => false;

	public override bool canAcceptVariableDrops => true;

	public T CallFunction<T>(string name, params object[] args)
	{
		return (T)CallFunction(name, args);
	}

	public object CallFunction(string name, params object[] args)
	{
		IInvokable value = null;
		if (functions.TryGetValue(name, out value))
		{
			return value.Invoke(args);
		}
		return null;
	}

	public void CallFunctionAsync(string name, Action<object> callback, params object[] args)
	{
		IInvokable value = null;
		if (functions.TryGetValue(name, out value))
		{
			value.InvokeAsync(callback, args);
		}
	}

	public UnityEngine.Object GetAgentComponent(Type type)
	{
		if (base.agent == null)
		{
			return null;
		}
		if (type == typeof(GameObject))
		{
			return base.agent.gameObject;
		}
		if (type == typeof(Transform))
		{
			return base.agent.transform;
		}
		if (type == typeof(Component))
		{
			return base.agent;
		}
		if (cachedAgentComponents == null)
		{
			cachedAgentComponents = new Dictionary<Type, Component>();
		}
		Component value = null;
		if (cachedAgentComponents.TryGetValue(type, out value))
		{
			return value;
		}
		if (typeof(Component).RTIsAssignableFrom(type) || type.RTIsInterface())
		{
			value = base.agent.GetComponent(type);
		}
		return cachedAgentComponents[type] = value;
	}

	protected override void OnGraphStarted()
	{
		if (!hasInitialized)
		{
			updatableNodes = new List<IUpdatable>();
			createHPTipsNodes = new List<IRenderCreateHPTips>();
			functions = new Dictionary<string, IInvokable>(StringComparer.Ordinal);
		}
		for (int i = 0; i < base.allNodes.Count; i++)
		{
			Node node = base.allNodes[i];
			if (node is MacroNodeWrapper)
			{
				MacroNodeWrapper macroNodeWrapper = (MacroNodeWrapper)node;
				if (macroNodeWrapper.macro != null)
				{
					macroNodeWrapper.CheckInstance();
					macroNodeWrapper.macro.StartGraph(base.agent, base.blackboard, autoUpdate: false);
				}
			}
			if (!hasInitialized)
			{
				if (node is IUpdatable)
				{
					updatableNodes.Add((IUpdatable)node);
				}
				if (node is IInvokable)
				{
					IInvokable invokable = (IInvokable)node;
					functions[invokable.GetInvocationID()] = invokable;
				}
				if (node is IRenderCreateHPTips)
				{
					createHPTipsNodes.Add((IRenderCreateHPTips)node);
				}
			}
		}
		if (!hasBinded)
		{
			for (int j = 0; j < base.allNodes.Count; j++)
			{
				if (base.allNodes[j] is FlowNode)
				{
					FlowNode obj = (FlowNode)base.allNodes[j];
					obj.AssignSelfInstancePort();
					obj.BindPorts();
				}
			}
		}
		hasInitialized = true;
		hasBinded = true;
	}

	public void Initialize()
	{
		if (!hasBinded)
		{
			for (int i = 0; i < base.allNodes.Count; i++)
			{
				if (base.allNodes[i] is FlowNode)
				{
					FlowNode obj = (FlowNode)base.allNodes[i];
					obj.AssignSelfInstancePort();
					obj.BindPorts();
				}
			}
		}
		hasBinded = true;
	}

	protected override void OnGraphUpdate()
	{
		if (updatableNodes != null && updatableNodes.Count > 0)
		{
			for (int i = 0; i < updatableNodes.Count; i++)
			{
				updatableNodes[i].Update();
			}
		}
	}

	protected override void OnGraphRenderCreateHPTips(int causeDamageAbilityID, int injuredEntityID, long value, DamageType type, int causeDamageEntityID, Vector3 position)
	{
		if (createHPTipsNodes != null && createHPTipsNodes.Count > 0)
		{
			for (int i = 0; i < createHPTipsNodes.Count; i++)
			{
				createHPTipsNodes[i].RenderCreateHPTips(causeDamageAbilityID, injuredEntityID, value, type, causeDamageEntityID, position);
			}
		}
	}

	protected override void OnGraphStoped()
	{
		for (int i = 0; i < base.allNodes.Count; i++)
		{
			Node node = base.allNodes[i];
			if (node is MacroNodeWrapper)
			{
				MacroNodeWrapper macroNodeWrapper = (MacroNodeWrapper)node;
				if (macroNodeWrapper.macro != null)
				{
					macroNodeWrapper.macro.Stop();
				}
			}
		}
	}
}
