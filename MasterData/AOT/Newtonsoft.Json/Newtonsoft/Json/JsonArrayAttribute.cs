using System;

namespace Newtonsoft.Json;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Interface, AllowMultiple = false)]
public sealed class JsonArrayAttribute : JsonContainerAttribute
{
}
