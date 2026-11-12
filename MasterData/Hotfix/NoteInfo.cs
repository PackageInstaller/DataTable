using System;

[Serializable]
public class NoteInfo
{
	public int Id;

	public int count;

	public void LoadFrom(NoteInfo other)
	{
		Id = other.Id;
		count = other.count;
	}
}
