using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;

namespace Ase;

public class BattleInput : IInputActionCollection2, IInputActionCollection, IEnumerable<InputAction>, IEnumerable, IDisposable
{
	public struct GameActions(BattleInput wrapper)
	{
		private BattleInput m_Wrapper = wrapper;

		public InputAction Move => m_Wrapper.m_Game_Move;

		public InputAction Roll => m_Wrapper.m_Game_Roll;

		public InputAction Attack => m_Wrapper.m_Game_Attack;

		public InputAction Skill1 => m_Wrapper.m_Game_Skill1;

		public InputAction Skill2 => m_Wrapper.m_Game_Skill2;

		public InputAction Skill3 => m_Wrapper.m_Game_Skill3;

		public InputAction SpecialSkill => m_Wrapper.m_Game_SpecialSkill;

		public InputAction SpecialSkill1 => m_Wrapper.m_Game_SpecialSkill1;

		public InputAction SpecialSkill2 => m_Wrapper.m_Game_SpecialSkill2;

		public InputAction PropSkill => m_Wrapper.m_Game_PropSkill;

		public InputAction Interaction => m_Wrapper.m_Game_Interaction;

		public InputAction DeputyPropSkill => m_Wrapper.m_Game_DeputyPropSkill;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Game;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(GameActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IGameActions instance)
		{
			if (instance != null && !m_Wrapper.m_GameActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_GameActionsCallbackInterfaces.Add(instance);
				Move.started += instance.OnMove;
				Move.performed += instance.OnMove;
				Move.canceled += instance.OnMove;
				Roll.started += instance.OnRoll;
				Roll.performed += instance.OnRoll;
				Roll.canceled += instance.OnRoll;
				Attack.started += instance.OnAttack;
				Attack.performed += instance.OnAttack;
				Attack.canceled += instance.OnAttack;
				Skill1.started += instance.OnSkill1;
				Skill1.performed += instance.OnSkill1;
				Skill1.canceled += instance.OnSkill1;
				Skill2.started += instance.OnSkill2;
				Skill2.performed += instance.OnSkill2;
				Skill2.canceled += instance.OnSkill2;
				Skill3.started += instance.OnSkill3;
				Skill3.performed += instance.OnSkill3;
				Skill3.canceled += instance.OnSkill3;
				SpecialSkill.started += instance.OnSpecialSkill;
				SpecialSkill.performed += instance.OnSpecialSkill;
				SpecialSkill.canceled += instance.OnSpecialSkill;
				SpecialSkill1.started += instance.OnSpecialSkill1;
				SpecialSkill1.performed += instance.OnSpecialSkill1;
				SpecialSkill1.canceled += instance.OnSpecialSkill1;
				SpecialSkill2.started += instance.OnSpecialSkill2;
				SpecialSkill2.performed += instance.OnSpecialSkill2;
				SpecialSkill2.canceled += instance.OnSpecialSkill2;
				PropSkill.started += instance.OnPropSkill;
				PropSkill.performed += instance.OnPropSkill;
				PropSkill.canceled += instance.OnPropSkill;
				Interaction.started += instance.OnInteraction;
				Interaction.performed += instance.OnInteraction;
				Interaction.canceled += instance.OnInteraction;
				DeputyPropSkill.started += instance.OnDeputyPropSkill;
				DeputyPropSkill.performed += instance.OnDeputyPropSkill;
				DeputyPropSkill.canceled += instance.OnDeputyPropSkill;
			}
		}

		private void UnregisterCallbacks(IGameActions instance)
		{
			Move.started -= instance.OnMove;
			Move.performed -= instance.OnMove;
			Move.canceled -= instance.OnMove;
			Roll.started -= instance.OnRoll;
			Roll.performed -= instance.OnRoll;
			Roll.canceled -= instance.OnRoll;
			Attack.started -= instance.OnAttack;
			Attack.performed -= instance.OnAttack;
			Attack.canceled -= instance.OnAttack;
			Skill1.started -= instance.OnSkill1;
			Skill1.performed -= instance.OnSkill1;
			Skill1.canceled -= instance.OnSkill1;
			Skill2.started -= instance.OnSkill2;
			Skill2.performed -= instance.OnSkill2;
			Skill2.canceled -= instance.OnSkill2;
			Skill3.started -= instance.OnSkill3;
			Skill3.performed -= instance.OnSkill3;
			Skill3.canceled -= instance.OnSkill3;
			SpecialSkill.started -= instance.OnSpecialSkill;
			SpecialSkill.performed -= instance.OnSpecialSkill;
			SpecialSkill.canceled -= instance.OnSpecialSkill;
			SpecialSkill1.started -= instance.OnSpecialSkill1;
			SpecialSkill1.performed -= instance.OnSpecialSkill1;
			SpecialSkill1.canceled -= instance.OnSpecialSkill1;
			SpecialSkill2.started -= instance.OnSpecialSkill2;
			SpecialSkill2.performed -= instance.OnSpecialSkill2;
			SpecialSkill2.canceled -= instance.OnSpecialSkill2;
			PropSkill.started -= instance.OnPropSkill;
			PropSkill.performed -= instance.OnPropSkill;
			PropSkill.canceled -= instance.OnPropSkill;
			Interaction.started -= instance.OnInteraction;
			Interaction.performed -= instance.OnInteraction;
			Interaction.canceled -= instance.OnInteraction;
			DeputyPropSkill.started -= instance.OnDeputyPropSkill;
			DeputyPropSkill.performed -= instance.OnDeputyPropSkill;
			DeputyPropSkill.canceled -= instance.OnDeputyPropSkill;
		}

		public void RemoveCallbacks(IGameActions instance)
		{
			if (m_Wrapper.m_GameActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IGameActions instance)
		{
			foreach (IGameActions gameActionsCallbackInterface in m_Wrapper.m_GameActionsCallbackInterfaces)
			{
				UnregisterCallbacks(gameActionsCallbackInterface);
			}
			m_Wrapper.m_GameActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public interface IGameActions
	{
		void OnMove(InputAction.CallbackContext context);

		void OnRoll(InputAction.CallbackContext context);

		void OnAttack(InputAction.CallbackContext context);

		void OnSkill1(InputAction.CallbackContext context);

		void OnSkill2(InputAction.CallbackContext context);

		void OnSkill3(InputAction.CallbackContext context);

		void OnSpecialSkill(InputAction.CallbackContext context);

		void OnSpecialSkill1(InputAction.CallbackContext context);

		void OnSpecialSkill2(InputAction.CallbackContext context);

		void OnPropSkill(InputAction.CallbackContext context);

		void OnInteraction(InputAction.CallbackContext context);

		void OnDeputyPropSkill(InputAction.CallbackContext context);
	}

	private readonly InputActionMap m_Game;

	private List<IGameActions> m_GameActionsCallbackInterfaces = new List<IGameActions>();

	private readonly InputAction m_Game_Move;

	private readonly InputAction m_Game_Roll;

	private readonly InputAction m_Game_Attack;

	private readonly InputAction m_Game_Skill1;

	private readonly InputAction m_Game_Skill2;

	private readonly InputAction m_Game_Skill3;

	private readonly InputAction m_Game_SpecialSkill;

	private readonly InputAction m_Game_SpecialSkill1;

	private readonly InputAction m_Game_SpecialSkill2;

	private readonly InputAction m_Game_PropSkill;

	private readonly InputAction m_Game_Interaction;

	private readonly InputAction m_Game_DeputyPropSkill;

	public InputActionAsset asset { get; }

	public InputBinding? bindingMask
	{
		get
		{
			return asset.bindingMask;
		}
		set
		{
			asset.bindingMask = value;
		}
	}

	public ReadOnlyArray<InputDevice>? devices
	{
		get
		{
			return asset.devices;
		}
		set
		{
			asset.devices = value;
		}
	}

	public ReadOnlyArray<InputControlScheme> controlSchemes => asset.controlSchemes;

	public IEnumerable<InputBinding> bindings => asset.bindings;

	public GameActions Game => new GameActions(this);

	public BattleInput()
	{
		asset = InputActionAsset.FromJson("{\r\n    \"name\": \"BattleInput\",\r\n    \"maps\": [\r\n        {\r\n            \"name\": \"Game\",\r\n            \"id\": \"012df68b-8d87-4ae0-b73f-a09cc1a19f51\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"Move\",\r\n                    \"type\": \"Value\",\r\n                    \"id\": \"0996d74d-0cd7-4efc-9ae0-6611c8452f72\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Roll\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"16c4d09f-757b-42cf-8af0-94cdbc67afc1\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Attack\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"9d599cc1-4adf-4ebd-86f2-26dee6ba21e4\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Skill1\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"6e62a1ab-d578-4d65-b5e3-063f67eca3a5\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Skill2\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"7beacd28-997e-4758-952a-2b6cac3823ae\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Skill3\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"d34a0853-4b07-4030-8ce5-963710153924\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SpecialSkill\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"6036d262-e3c4-4bf6-8634-4fded7080fb1\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SpecialSkill1\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"6e1f6849-b5c6-4d9c-9280-642cf8e5927d\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SpecialSkill2\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"8f0a75e0-11a6-4b02-8da3-5752d5d28a23\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"PropSkill\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"59e99644-6b12-46de-8c43-468bcc042bb8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Interaction\",\r\n                    \"type\": \"Button\",\r\n                    \"id\": \"dc0cb52a-f421-43d6-9ed1-1babb57e4cef\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"DeputyPropSkill\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b499074f-254a-4b0a-876c-b6abbd0ce54c\",\r\n                    \"expectedControlType\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"WASD\",\r\n                    \"id\": \"a4680614-8e84-42e2-a8d5-b86b9d07c018\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"Up\",\r\n                    \"id\": \"2fd7f702-6a24-4ca8-855b-287706c33472\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"Down\",\r\n                    \"id\": \"e4d38f08-377d-43a5-b100-72192a814410\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"Left\",\r\n                    \"id\": \"ba006fc7-3202-43b4-bed5-19c487814859\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"Right\",\r\n                    \"id\": \"3914cb79-2872-4e12-a55f-25a71ee6068e\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b4083b4a-d098-4b41-8a00-9587b0d6a69f\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"585b23b4-eef9-4988-ae79-3059e887da25\",\r\n                    \"path\": \"<Keyboard>/space\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Roll\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6b18ed12-546d-457a-9d1e-41064d6ae53f\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Roll\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"13a55596-5488-4806-954c-f32b1ee88646\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Attack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9da3c5bf-1be3-4421-9f41-5962a1c88213\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Attack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"850cc8b2-c7be-4c33-a8cb-177afdc1b324\",\r\n                    \"path\": \"<Keyboard>/u\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7f7845e0-53ac-4c15-8ca9-7e9f18b0fb3a\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8a7f2c29-44a3-469b-83c8-9c047cb4d8f2\",\r\n                    \"path\": \"<Keyboard>/i\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"36955c94-682b-409c-8143-9b2ad11a6f09\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9a646add-dd24-48a9-bf66-6f7b0351d3a3\",\r\n                    \"path\": \"<Keyboard>/o\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill3\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f78f226a-fadc-4617-925f-3ba9c3dfe38b\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Skill3\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d8505e95-08d7-4e01-a80f-f4a5e7d6ebd0\",\r\n                    \"path\": \"<Keyboard>/l\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6a336386-6e11-42cc-a09c-b93bc3dbb543\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"25dc0381-97c8-4d98-8469-7044a1eb49c8\",\r\n                    \"path\": \"<Keyboard>/1\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"82dc5e6e-7a15-4fd0-bc04-ae534080b0b3\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a5b6c80c-d584-430f-9aec-7eae7c9922cb\",\r\n                    \"path\": \"<Keyboard>/2\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7064e8a4-ac70-4a15-9613-8fdcc9aea082\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialSkill2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0525486b-ce2b-4f80-ba82-5293ea95882c\",\r\n                    \"path\": \"<Keyboard>/n\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PropSkill\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ad5105ba-e67b-4414-af53-3a3aa10fc0c3\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Interaction\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4b38ce2f-99b6-471e-a3cd-fc0f7931f53c\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Interaction\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1c05d201-9dfc-48d2-98d7-f32d7403e7d0\",\r\n                    \"path\": \"<Keyboard>/m\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"DeputyPropSkill\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        }\r\n    ],\r\n    \"controlSchemes\": []\r\n}");
		m_Game = asset.FindActionMap("Game", throwIfNotFound: true);
		m_Game_Move = m_Game.FindAction("Move", throwIfNotFound: true);
		m_Game_Roll = m_Game.FindAction("Roll", throwIfNotFound: true);
		m_Game_Attack = m_Game.FindAction("Attack", throwIfNotFound: true);
		m_Game_Skill1 = m_Game.FindAction("Skill1", throwIfNotFound: true);
		m_Game_Skill2 = m_Game.FindAction("Skill2", throwIfNotFound: true);
		m_Game_Skill3 = m_Game.FindAction("Skill3", throwIfNotFound: true);
		m_Game_SpecialSkill = m_Game.FindAction("SpecialSkill", throwIfNotFound: true);
		m_Game_SpecialSkill1 = m_Game.FindAction("SpecialSkill1", throwIfNotFound: true);
		m_Game_SpecialSkill2 = m_Game.FindAction("SpecialSkill2", throwIfNotFound: true);
		m_Game_PropSkill = m_Game.FindAction("PropSkill", throwIfNotFound: true);
		m_Game_Interaction = m_Game.FindAction("Interaction", throwIfNotFound: true);
		m_Game_DeputyPropSkill = m_Game.FindAction("DeputyPropSkill", throwIfNotFound: true);
	}

	public void Dispose()
	{
		UnityEngine.Object.Destroy(asset);
	}

	public bool Contains(InputAction action)
	{
		return asset.Contains(action);
	}

	public IEnumerator<InputAction> GetEnumerator()
	{
		return asset.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void Enable()
	{
		asset.Enable();
	}

	public void Disable()
	{
		asset.Disable();
	}

	public InputAction FindAction(string actionNameOrId, bool throwIfNotFound = false)
	{
		return asset.FindAction(actionNameOrId, throwIfNotFound);
	}

	public int FindBinding(InputBinding bindingMask, out InputAction action)
	{
		return asset.FindBinding(bindingMask, out action);
	}
}
