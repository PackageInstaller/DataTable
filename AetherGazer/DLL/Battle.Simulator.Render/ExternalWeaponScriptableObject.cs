using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "ExternalWeapon", menuName = "ScriptableObjects/外置武器数据", order = 1)]
public class ExternalWeaponScriptableObject : ScriptableObject
{
	public List<string> m_Paths = new List<string>();

	public List<Object> m_Assets = new List<Object>();

	public List<Vector3> m_LocalPositions = new List<Vector3>();

	public List<Quaternion> m_LocalRotations = new List<Quaternion>();

	public List<Vector3> m_LocalScales = new List<Vector3>();
}
