using System;
using System.Collections.Generic;
using System.Reflection;
using JetBrains.Annotations;
using UnityEngine.InputSystem;

namespace Unity.VisualScripting.FullSerializer;

[UsedImplicitly]
public class InputAction_DirectConverter : fsDirectConverter<InputAction>
{
	protected override fsResult DoSerialize(InputAction model, Dictionary<string, fsData> serialized)
	{
		return fsResult.Success + SerializeMember(serialized, null, "id", model.id.ToString()) + SerializeMember(serialized, null, "name", model.name.ToString()) + SerializeMember(serialized, null, "expectedControlType", model.expectedControlType) + SerializeMember(serialized, null, "type", model.type);
	}

	protected override fsResult DoDeserialize(Dictionary<string, fsData> data, ref InputAction model)
	{
		fsResult result = fsResult.Success + DeserializeMember<string>(data, null, "id", out var value) + DeserializeMember<string>(data, null, "name", out var value2) + DeserializeMember<string>(data, null, "expectedControlType", out var value3) + DeserializeMember<InputActionType>(data, null, "type", out var value4);
		model = MakeInputActionWithId(value, value2, value3, value4);
		return result;
	}

	public static InputAction MakeInputActionWithId(string actionId, string actionName, string expectedControlType, InputActionType type)
	{
		InputAction inputAction = new InputAction();
		typeof(InputAction).GetField("m_Id", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(inputAction, actionId);
		typeof(InputAction).GetField("m_Name", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(inputAction, actionName);
		typeof(InputAction).GetField("m_Type", BindingFlags.Instance | BindingFlags.NonPublic).SetValue(inputAction, type);
		inputAction.expectedControlType = expectedControlType;
		return inputAction;
	}

	public override object CreateInstance(fsData data, Type storageType)
	{
		return new InputAction();
	}
}
