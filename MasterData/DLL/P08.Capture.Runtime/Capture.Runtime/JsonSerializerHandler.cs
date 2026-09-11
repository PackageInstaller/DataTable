using UnityEngine;

namespace Capture.Runtime;

public class JsonSerializerHandler : ICaptureStageSerializer
{
	public StageData DeSerialize(object source)
	{
		return JsonUtility.FromJson<StageData>(source as string);
	}

	public StageData Load(string fileName)
	{
		string text = Asset.Load<TextAsset>($"Map/Capture/Config/{fileName}.asset")?.text;
		if (text == null)
		{
			return null;
		}
		return JsonUtility.FromJson<StageData>(text);
	}

	public object Save(string fileName, StageData stageData)
	{
		return Serialize(stageData) as string;
	}

	public object Serialize(StageData stageData)
	{
		return JsonUtility.ToJson(stageData);
	}
}
