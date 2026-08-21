using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.InputSystem;

namespace Ase.ECS;

public class InputSystem : BaseSystem
{
	private bool isPress;

	private Vector2 _inputUv = Vector2.zero;

	private readonly Queue<MsgPlayerInput> _optionQueues = new Queue<MsgPlayerInput>();

	private int PauseCount;

	private HeroEntity _operationEntity;

	private ISubscription<string> onKeySettingChanged;

	private BattleInput battleInput;

	private CommandSystem _commandSystem;

	public bool IsPress
	{
		get
		{
			return isPress;
		}
		private set
		{
			isPress = value;
		}
	}

	private bool Paused => PauseCount > 0;

	protected override bool IsLogicSystem => false;

	public CommandSystem CommandSystem
	{
		get
		{
			if (_commandSystem == null)
			{
				_commandSystem = GetSystem<CommandSystem>();
				return _commandSystem;
			}
			return _commandSystem;
		}
	}

	public void BindTargetEntity(HeroEntity heroEntity)
	{
		_operationEntity = heroEntity;
	}

	public void SetPaused(bool paused)
	{
		PauseCount += (paused ? 1 : (-1));
	}

	public override void OnInit(object data = null)
	{
		IMessenger service = Context.GetApplicationContext().GetService<IMessenger>();
		onKeySettingChanged = service.Subscribe<string>("Setting.SettingMessage", LoadBindingOverridesFromJson);
		battleInput = new BattleInput();
	}

	public override void OnAwake(object data = null)
	{
		LoadBindingOverridesFromJson();
	}

	public override void OnPause()
	{
		base.OnPause();
		if (isPress)
		{
			IsPress = !isPress;
		}
	}

	public override void OnUpdate(float deltaTime)
	{
	}

	private void LoadBindingOverridesFromJson(string obj = "")
	{
		battleInput.Disable();
		string json = PlayerPrefs.GetString("Setting.ActionData");
		battleInput.LoadBindingOverridesFromJson(json);
		battleInput.Enable();
	}

	public override void OnDispose()
	{
		_operationEntity = null;
		_commandSystem = null;
		while (_optionQueues.Count > 0)
		{
			_optionQueues.Dequeue().OnDispose();
		}
		onKeySettingChanged?.Dispose();
		onKeySettingChanged = null;
		battleInput.Disable();
		battleInput.Dispose();
		base.OnDispose();
	}
}
