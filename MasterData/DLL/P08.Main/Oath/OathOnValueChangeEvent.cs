using System;
using UnityEngine.Events;

namespace Oath;

[Serializable]
public class OathOnValueChangeEvent : UnityEvent<string, float>
{
}
