using System.Runtime.InteropServices;

namespace System;

[Serializable]
[ComVisible(true)]
public delegate void AppDomainInitializer(string[] args);
