using System;
using UnityEngine;

namespace ACT;

[DisallowMultipleComponent]
public sealed class WindowsWindowMoveMonitor : MonoBehaviour
{
	public static event Action<bool> OnWindowMoveStateChanged;
}
