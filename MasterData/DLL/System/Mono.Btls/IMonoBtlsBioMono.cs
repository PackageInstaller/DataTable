namespace Mono.Btls;

internal interface IMonoBtlsBioMono
{
	int Read(byte[] buffer, int offset, int size, out bool wantMore);

	bool Write(byte[] buffer, int offset, int size);

	void Flush();

	void Close();
}
