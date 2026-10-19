using UnityEngine;

namespace ACT.DialogueSystem;

public class SoundNode : DialogueNode
{
	[Header("音效")]
	[ValuePickerFromExcel("dialogueSFX.xlsx", "dialogueSFXData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int soundId;
}
