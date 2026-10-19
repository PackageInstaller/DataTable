using UnityEngine;

namespace ACT.DialogueSystem;

public class BgmNode : DialogueNode
{
	[Header("背景音乐")]
	[ValuePickerFromExcel("dialogueBGM.xlsx", "dialogueBGMData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int bgmId;
}
