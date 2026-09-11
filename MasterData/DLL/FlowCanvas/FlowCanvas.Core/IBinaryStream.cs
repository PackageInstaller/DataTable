using System.IO;

namespace FlowCanvas.Core;

public interface IBinaryStream
{
	void Read(BinaryReader br);

	void Write(BinaryWriter wr);
}
