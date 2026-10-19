using System;

namespace UnityEngine.InputSystem.Layouts;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = true)]
public sealed class InputControlAttribute : PropertyAttribute
{
	public string layout { get; set; }

	public string variants { get; set; }

	public string name { get; set; }

	public string format { get; set; }

	public string usage { get; set; }

	public string[] usages { get; set; }

	public string parameters { get; set; }

	public string processors { get; set; }

	public string alias { get; set; }

	public string[] aliases { get; set; }

	public string useStateFrom { get; set; }

	public uint bit { get; set; } = uint.MaxValue;

	public uint offset { get; set; } = uint.MaxValue;

	public uint sizeInBits { get; set; }

	public int arraySize { get; set; }

	public string displayName { get; set; }

	public string shortDisplayName { get; set; }

	public bool noisy { get; set; }

	public bool synthetic { get; set; }

	public bool dontReset { get; set; }

	public object defaultState { get; set; }

	public object minValue { get; set; }

	public object maxValue { get; set; }
}
