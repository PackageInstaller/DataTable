using System;

namespace Sirenix.Serialization;

public interface IAskIfCanFormatTypes
{
	bool CanFormatType(Type type);
}
