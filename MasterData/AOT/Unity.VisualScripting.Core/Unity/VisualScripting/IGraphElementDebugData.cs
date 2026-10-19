using System;

namespace Unity.VisualScripting;

public interface IGraphElementDebugData
{
	Exception runtimeException { get; set; }
}
