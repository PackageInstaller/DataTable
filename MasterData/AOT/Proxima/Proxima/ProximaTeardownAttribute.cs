using System;
using UnityEngine.Scripting;

namespace Proxima;

[AttributeUsage(AttributeTargets.Method)]
internal class ProximaTeardownAttribute : PreserveAttribute
{
}
