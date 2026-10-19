using UnityEngine;

namespace ACT.DialogueSystem;

public class EnvBgmNode : DialogueNode
{
	[Header("环境音乐")]
	[ValuePickerFromExcel("dialogueEnvBGM.xlsx", "dialogueEnvBGMData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int bgmId;
}
