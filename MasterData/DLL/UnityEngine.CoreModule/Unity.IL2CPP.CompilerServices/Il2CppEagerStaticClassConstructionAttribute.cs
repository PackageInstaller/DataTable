using System;

namespace Unity.IL2CPP.CompilerServices;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct, Inherited = false, AllowMultiple = false)]
internal class Il2CppEagerStaticClassConstructionAttribute : Attribute
{
}
