namespace ACT;

internal readonly struct ZipExtractionEntry(string path, long size, string hashSizeFileName = null, bool deleteAfterExtract = true, bool deleteOnExtractFailure = true, string[] tags = null)
{
	public readonly string Path = path;

	public readonly long Size = size;

	public readonly string HashSizeFileName = hashSizeFileName;

	public readonly bool DeleteAfterExtract = deleteAfterExtract;

	public readonly bool DeleteOnExtractFailure = deleteOnExtractFailure;

	public readonly string[] Tags = tags;
}
