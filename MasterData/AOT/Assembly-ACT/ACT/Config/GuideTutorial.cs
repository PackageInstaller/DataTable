using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class GuideTutorial
{
	public readonly int id;

	public readonly int tutorialType;

	public readonly int tipType;

	public readonly int tutorialTitle;

	public readonly int multimediaType;

	public readonly int[] pictureid = new int[0];

	public readonly int[] tutorialDesc = new int[0];

	public readonly int[] pictureidPC = new int[0];

	public readonly int[] tutorialDescPC = new int[0];

	public readonly int[] pictureidHandy = new int[0];

	public readonly int[] tutorialDescHandy = new int[0];

	public readonly List<ItemKv> reward;

	public readonly int defaultDisplay;

	public readonly int displayTime;

	public readonly int sort;

	public GuideTutorial(int id, int tutorialType, int tipType, int tutorialTitle, int multimediaType, int[] pictureid, int[] tutorialDesc, int[] pictureidPC, int[] tutorialDescPC, int[] pictureidHandy, int[] tutorialDescHandy, List<ItemKv> reward, int defaultDisplay, int displayTime, int sort)
	{
		this.id = id;
		this.tutorialType = tutorialType;
		this.tipType = tipType;
		this.tutorialTitle = tutorialTitle;
		this.multimediaType = multimediaType;
		this.pictureid = pictureid;
		this.tutorialDesc = tutorialDesc;
		this.pictureidPC = pictureidPC;
		this.tutorialDescPC = tutorialDescPC;
		this.pictureidHandy = pictureidHandy;
		this.tutorialDescHandy = tutorialDescHandy;
		this.reward = reward;
		this.defaultDisplay = defaultDisplay;
		this.displayTime = displayTime;
		this.sort = sort;
	}
}
