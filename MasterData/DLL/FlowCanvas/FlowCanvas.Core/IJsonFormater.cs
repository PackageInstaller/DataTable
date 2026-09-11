using LitJson;
using UnityEngine;

namespace FlowCanvas.Core;

public interface IJsonFormater
{
	void ReadFromJson(JsonData jd);

	void WriteToJson(JsonWriter jw, Collider col);
}
