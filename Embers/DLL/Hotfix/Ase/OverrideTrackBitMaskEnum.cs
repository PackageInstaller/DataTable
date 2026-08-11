using System;

namespace Ase;

[Flags]
public enum OverrideTrackBitMaskEnum
{
	MainTrack = 2,
	FaceTrack = 4,
	TalkTrack = 8,
	ExtraTrack = 0x10,
	AudioTrack = 0x20,
	All = MainTrack | FaceTrack | TalkTrack | ExtraTrack | AudioTrack
}
