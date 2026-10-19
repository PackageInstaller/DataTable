using ACT.Battle;
using UnityEngine;

namespace Bamboo.ECS;

public static class Entity_Extension
{
	public static string DebugName(this Entity entity, bool detailed = false)
	{
		if (detailed)
		{
			object arg = (entity.IsValid ? ((object)entity.Id) : "<compId not found>");
			GameObject root = entity.GetRoot();
			string arg2 = (((object)root != null) ? root.name : "<root not found>");
			CompStateObject compStateObject = entity.GetCompStateObject();
			return $"[{arg}]{arg2}{((compStateObject != null && compStateObject.StateWorldAssetData != null) ? $"={compStateObject.StateWorldAssetData}" : null)}";
		}
		object arg3 = (entity.IsValid ? ((object)entity.Id) : "<compId not found>");
		GameObject root2 = entity.GetRoot();
		return string.Format("[{0}]{1}", arg3, ((object)root2 != null) ? root2.name : "<root not found>");
	}
}
