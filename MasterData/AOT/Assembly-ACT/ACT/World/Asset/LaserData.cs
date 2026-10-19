using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class LaserData : StateWorldAssetData
{
	[Tooltip("需要添加的技能名字")]
	public string[] abilities;

	[Tooltip("表中Entity的id")]
	public int id = 6;

	[Tooltip("是否回溯")]
	public bool isReCall;

	[Tooltip("是否是横向激光")]
	public bool isHorizontal;

	[Tooltip("回溯速度")]
	public float velocity = 3f;

	[Tooltip("是否移动")]
	public bool isMove;

	[Tooltip("移动方向")]
	public Vector3 direction;

	[Tooltip("移动长度")]
	public float length;

	[Tooltip("是否旋转")]
	public bool isRotate;

	[Tooltip("旋转角度")]
	public Vector3 rotateAngle;

	[Tooltip("时间间隔，越大速度越慢")]
	[Range(0.1f, float.MaxValue)]
	public float interval = 2f;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[Tooltip("在服务器存档？")]
	public bool m_ServiceSave = true;

	[SerializeField]
	internal int m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
