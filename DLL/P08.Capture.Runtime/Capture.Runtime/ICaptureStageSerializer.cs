namespace Capture.Runtime;

public interface ICaptureStageSerializer
{
	StageData DeSerialize(object source);

	object Serialize(StageData stageData);

	object Save(string fileName, StageData stageData);

	StageData Load(string fileName);
}
