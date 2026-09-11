using System;
using System.Buffers;
using System.Collections.Generic;
using MessagePack;
using Nerdbank.Streams;
using UnityEngine;

public class BattleUIAdapterData
{
	public class Data
	{
		public string path;

		public Vector2 offest;

		public float scale;
	}

	public List<Data> datas = new List<Data>();

	public string Serialize()
	{
		string text = "";
		using Sequence<byte> sequence = new Sequence<byte>();
		MessagePackWriter messagePackWriter = new MessagePackWriter(sequence);
		messagePackWriter.Write(datas.Count);
		foreach (Data data in datas)
		{
			messagePackWriter.Write(data.path);
			messagePackWriter.Write(data.offest.x);
			messagePackWriter.Write(data.offest.y);
			messagePackWriter.Write(data.scale);
		}
		messagePackWriter.Flush();
		return Convert.ToBase64String(sequence.AsReadOnlySequence.ToArray<byte>());
	}

	public void Deserialize(string s)
	{
		datas.Clear();
		MessagePackReader messagePackReader = new MessagePackReader(Convert.FromBase64String(s));
		int num = messagePackReader.ReadInt32();
		for (int i = 0; i < num; i++)
		{
			Data data = new Data();
			data.path = messagePackReader.ReadString();
			Vector2 zero = Vector2.zero;
			zero.x = messagePackReader.ReadSingle();
			zero.y = messagePackReader.ReadSingle();
			data.offest = zero;
			data.scale = messagePackReader.ReadSingle();
			datas.Add(data);
		}
	}
}
