using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using CsvHelper;
using CsvHelper.Configuration;

namespace Yarn.Unity;

public struct StringTableEntry(StringTableEntry s)
{
	public string Language = s.Language;

	public string ID = s.ID;

	public string Text = s.Text;

	public string File = s.File;

	public string Node = s.Node;

	public string LineNumber = s.LineNumber;

	public string Lock = s.Lock;

	public string Comment = s.Comment;

	private static Configuration CsvConfiguration;

	private static Configuration GetConfiguration()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Expected O, but got Unknown
		if (CsvConfiguration == null)
		{
			CsvConfiguration = new Configuration(CultureInfo.InvariantCulture)
			{
				MemberTypes = (MemberTypes)2
			};
		}
		return CsvConfiguration;
	}

	public static IEnumerable<StringTableEntry> ParseFromCSV(string sourceText)
	{
		//IL_0165: Expected O, but got Unknown
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Expected O, but got Unknown
		try
		{
			using StringReader stringReader = new StringReader(sourceText);
			CsvReader val = new CsvReader((TextReader)stringReader, GetConfiguration());
			try
			{
				List<StringTableEntry> list = new List<StringTableEntry>();
				val.Read();
				val.ReadHeader();
				string text = default(string);
				string text2 = default(string);
				string text3 = default(string);
				string text4 = default(string);
				string text5 = default(string);
				string text6 = default(string);
				string text7 = default(string);
				string text8 = default(string);
				while (val.Read())
				{
					val.TryGetField<string>("language", ref text);
					val.TryGetField<string>("lock", ref text2);
					val.TryGetField<string>("comment", ref text3);
					val.TryGetField<string>("id", ref text4);
					val.TryGetField<string>("text", ref text5);
					val.TryGetField<string>("file", ref text6);
					val.TryGetField<string>("node", ref text7);
					val.TryGetField<string>("lineNumber", ref text8);
					StringTableEntry item = new StringTableEntry
					{
						Language = (text ?? string.Empty),
						ID = (text4 ?? string.Empty),
						Text = (text5 ?? string.Empty),
						File = (text6 ?? string.Empty),
						Node = (text7 ?? string.Empty),
						LineNumber = (text8 ?? string.Empty),
						Lock = (text2 ?? string.Empty),
						Comment = (text3 ?? string.Empty)
					};
					list.Add(item);
				}
				return list;
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
		}
		catch (CsvHelperException ex)
		{
			CsvHelperException arg = ex;
			throw new ArgumentException($"Error reading CSV file: {arg}");
		}
	}

	public static string CreateCSV(IEnumerable<StringTableEntry> entries)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Expected O, but got Unknown
		using StringWriter stringWriter = new StringWriter();
		CsvWriter val = new CsvWriter((TextWriter)stringWriter, GetConfiguration());
		string[] array = new string[8] { "language", "id", "text", "file", "node", "lineNumber", "lock", "comment" };
		foreach (string text in array)
		{
			val.WriteField(text);
		}
		val.NextRecord();
		foreach (StringTableEntry entry in entries)
		{
			array = new string[8] { entry.Language, entry.ID, entry.Text, entry.File, entry.Node, entry.LineNumber, entry.Lock, entry.Comment };
			foreach (string text2 in array)
			{
				val.WriteField(text2);
			}
			val.NextRecord();
		}
		return stringWriter.ToString();
	}

	public override string ToString()
	{
		return "StringTableEntry: lang=" + Language + " id=" + ID + " text=\"" + Text + "\" file=" + File + " node=" + Node + " line=" + LineNumber + " lock=" + Lock + " comment=" + Comment;
	}

	public override bool Equals(object obj)
	{
		if (obj is StringTableEntry stringTableEntry && Language == stringTableEntry.Language && ID == stringTableEntry.ID && Text == stringTableEntry.Text && File == stringTableEntry.File && Node == stringTableEntry.Node && LineNumber == stringTableEntry.LineNumber && Lock == stringTableEntry.Lock)
		{
			return Comment == stringTableEntry.Comment;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Language.GetHashCode() ^ ID.GetHashCode() ^ Text.GetHashCode() ^ File.GetHashCode() ^ Node.GetHashCode() ^ LineNumber.GetHashCode() ^ Lock.GetHashCode() ^ Comment.GetHashCode();
	}
}
