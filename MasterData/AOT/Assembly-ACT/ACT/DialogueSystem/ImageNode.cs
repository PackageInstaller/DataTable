using UnityEngine;

namespace ACT.DialogueSystem;

public class ImageNode : DialogueNode
{
	[Header("插图（小于 0 隐藏，0 保持当前插图）")]
	[ValuePickerFromExcel("dialogueImage.xlsx", "dialogueImageData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "path")]
	public int imageId;

	[Header("插图位置")]
	public ChatImagePosition imagePosition;

	[Header("插图自定义位置")]
	public float imageOffset;
}
