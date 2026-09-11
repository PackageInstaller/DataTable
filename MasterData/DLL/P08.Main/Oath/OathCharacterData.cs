using System;
using System.Collections.Generic;
using UnityEngine;

namespace Oath;

[Serializable]
[CreateAssetMenu(fileName = "OathCharacterData", menuName = "誓约数据创建入口/角色数据")]
public class OathCharacterData : ScriptableObject
{
	public int characterID = -1;

	public Vector3 pos;

	public Vector3 rot;

	public List<OathInterationTreeNode> treeNodeList;

	public int beginTreeNodeIndex = -1;
}
