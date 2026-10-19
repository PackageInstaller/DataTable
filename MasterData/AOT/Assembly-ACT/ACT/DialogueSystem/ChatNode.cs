using System;
using UnityEngine;

namespace ACT.DialogueSystem;

[Serializable]
public class ChatNode : DialogueNode
{
	public long key;

	[Header("重要(不能跳过)")]
	public bool important;

	[Header("没有UI")]
	public bool noUI;

	[Header("说话人")]
	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "nameLocal")]
	public int speakerId;

	[Header("显示左侧说话人模型")]
	public bool showLeftModel;

	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "nameLocal", ValuePickerFromExcelAttribute.ValueType.String, nameCol = "nameLocal")]
	public string speaker;

	[Header("金色表情(主角)")]
	public bool goldSpeakerAvatar;

	[Header("表情(主角)")]
	public int speakerAvatar;

	[Header("无文本框")]
	public bool subtitle;

	[Header("文字内容")]
	[TextArea(8, 8)]
	public string content;

	[Header("文字内容(男)")]
	[TextArea(8, 8)]
	public string content_male;

	[Header("关键词")]
	public int[] keywords = Array.Empty<int>();

	[Header("不能通过点击快速完成本句话，勾选时默认开启AutoNext")]
	public bool noClick;

	[Header("自动下一句")]
	public bool autoNext;

	[Header("自动下一句的延迟(若自动播放), <0表示默认0.5s")]
	public float autoNextDelay = 0.5f;

	[Header("出字间隔(ms, 默认35ms，小于默认值则会使用默认值)")]
	public int contentTypeSpeed;

	[HideInInspector]
	[Header("音效")]
	[ValuePickerFromExcel("dialogueSFX.xlsx", "dialogueSFXData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int soundId;

	[HideInInspector]
	[Header("插图")]
	[ValuePickerFromExcel("dialogueImage.xlsx", "dialogueImageData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "description")]
	public int image;

	[HideInInspector]
	[Header("插图位置")]
	public ChatImagePosition imagePosition;

	[HideInInspector]
	[Header("插图位置")]
	public float imageOffset;

	[Range(0f, 3f)]
	[Header("模板")]
	public int stageMode;

	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "nameLocal")]
	public int actor1;

	public int actorAnim1;

	public string actorAnim1s;

	public int actorFace1;

	public string actorFace1s;

	[ValuePickerFromExcel("dialogueEmoji.xlsx", "dialogueEmojiData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "desc")]
	public int emoji1;

	public UIConversationScene.StageActorLookAtType actorLookAtType1;

	public Vector3 actorPositionOffset1;

	public float actorRotationYOffset1;

	public float actorScaleOffset1;

	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "nameLocal")]
	public int actor2;

	public int actorAnim2;

	public string actorAnim2s;

	public int actorFace2;

	public string actorFace2s;

	[ValuePickerFromExcel("dialogueEmoji.xlsx", "dialogueEmojiData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "desc")]
	public int emoji2;

	public UIConversationScene.StageActorLookAtType actorLookAtType2;

	public Vector3 actorPositionOffset2;

	public float actorRotationYOffset2;

	public float actorScaleOffset2;

	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "nameLocal")]
	public int actor3;

	public int actorAnim3;

	public string actorAnim3s;

	public int actorFace3;

	public string actorFace3s;

	[ValuePickerFromExcel("dialogueEmoji.xlsx", "dialogueEmojiData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "desc")]
	public int emoji3;

	public UIConversationScene.StageActorLookAtType actorLookAtType3;

	public Vector3 actorPositionOffset3;

	public float actorRotationYOffset3;

	public float actorScaleOffset3;

	[ValuePickerFromExcel("dialogueCharacter.xlsx", "dialogueCharacterData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "nameLocal")]
	public int actor4;

	public int actorAnim4;

	public string actorAnim4s;

	public int actorFace4;

	public string actorFace4s;

	[ValuePickerFromExcel("dialogueEmoji.xlsx", "dialogueEmojiData", "id", "id", ValuePickerFromExcelAttribute.ValueType.Int, nameCol = "desc")]
	public int emoji4;

	public UIConversationScene.StageActorLookAtType actorLookAtType4;

	public Vector3 actorPositionOffset4;

	public float actorRotationYOffset4;

	public float actorScaleOffset4;

	[Header("滤镜")]
	public int effect;
}
