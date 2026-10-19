using UnityEngine;

namespace ACT.DialogueSystem;

public class LoadBgNode : DialogueNode
{
	[Header("背景Id")]
	[ValuePickerFromExcel("dialogueBackground.xlsx", "dialogueBackgroundData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "path")]
	public int bgId;

	[Header("背景Id(男)")]
	[ValuePickerFromExcel("dialogueBackground.xlsx", "dialogueBackgroundData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "path")]
	public int bgId_male;

	[Header("初始缩放")]
	public float initScale = 1f;

	[Header("初始偏移")]
	public Vector2 initOffset = new Vector2(0f, 0f);
}
