using System;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace NodeCanvas.DialogueTrees;

[Serializable]
public class Statement : IStatement
{
	[SerializeField]
	private string _text = string.Empty;

	[SerializeField]
	private AudioClip _audio;

	[SerializeField]
	private string _meta = string.Empty;

	public string text
	{
		get
		{
			return _text;
		}
		set
		{
			_text = value;
		}
	}

	public AudioClip audio
	{
		get
		{
			return _audio;
		}
		set
		{
			_audio = value;
		}
	}

	public string meta
	{
		get
		{
			return _meta;
		}
		set
		{
			_meta = value;
		}
	}

	public Statement()
	{
	}

	public Statement(string text)
	{
		this.text = text;
	}

	public Statement(string text, AudioClip audio)
	{
		this.text = text;
		this.audio = audio;
	}

	public Statement(string text, AudioClip audio, string meta)
	{
		this.text = text;
		this.audio = audio;
		this.meta = meta;
	}

	public IStatement BlackboardReplace(IBlackboard bb)
	{
		Statement statement = JSONSerializer.Clone(this);
		statement.text = statement.text.ReplaceWithin('[', ']', delegate(string input)
		{
			object obj = null;
			if (bb != null)
			{
				Variable variable = bb.GetVariable(input, typeof(object));
				if (variable != null)
				{
					obj = variable.value;
				}
			}
			if (input.Contains("/"))
			{
				GlobalBlackboard globalBlackboard = GlobalBlackboard.Find(input.Split('/').First());
				if (globalBlackboard != null)
				{
					Variable variable2 = globalBlackboard.GetVariable(input.Split('/').Last(), typeof(object));
					if (variable2 != null)
					{
						obj = variable2.value;
					}
				}
			}
			return (obj == null) ? input : obj.ToString();
		});
		return statement;
	}

	public override string ToString()
	{
		return text;
	}
}
