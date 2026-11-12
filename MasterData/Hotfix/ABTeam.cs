using System;
using System.Collections.Generic;

[Serializable]
public struct ABTeam
{
	public ABCharactorInfo charMain;

	public ABCharactorInfo charSub1;

	public ABCharactorInfo charSub2;

	public List<ABDiscInfo> discData;

	public List<ABNoteInfo> noteData;
}
