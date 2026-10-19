using System;
using System.ComponentModel;
using System.Reflection;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal static class InputInteraction
{
	public static TypeTable s_Interactions;

	public static Type GetValueType(Type interactionType)
	{
		if (interactionType == null)
		{
			throw new ArgumentNullException("interactionType");
		}
		return TypeHelpers.GetGenericTypeArgumentFromHierarchy(interactionType, typeof(IInputInteraction<>), 0);
	}

	public static string GetDisplayName(string interaction)
	{
		if (string.IsNullOrEmpty(interaction))
		{
			throw new ArgumentNullException("interaction");
		}
		Type type = s_Interactions.LookupTypeRegistration(interaction);
		if (type == null)
		{
			return interaction;
		}
		return GetDisplayName(type);
	}

	public static string GetDisplayName(Type interactionType)
	{
		if (interactionType == null)
		{
			throw new ArgumentNullException("interactionType");
		}
		DisplayNameAttribute customAttribute = interactionType.GetCustomAttribute<DisplayNameAttribute>();
		if (customAttribute == null)
		{
			if (interactionType.Name.EndsWith("Interaction"))
			{
				return interactionType.Name.Substring(0, interactionType.Name.Length - "Interaction".Length);
			}
			return interactionType.Name;
		}
		return customAttribute.DisplayName;
	}
}
