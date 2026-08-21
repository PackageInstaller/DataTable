using System;

namespace MessagePack.Internal;

internal static class DateTimeConstants
{
	internal const long BclSecondsAtUnixEpoch = 62135596800L;

	internal const int NanosecondsPerTick = 100;

	internal static readonly DateTime UnixEpoch = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
}
