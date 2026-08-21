using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class NPCDialogData
{
	public int id;

	public List<string> texts;

	public List<bool> isSticker;

	public List<float> duratime;

	public Vector3 pos;

	public Vector3 posOri;

	public NPCDialogData(int id, List<string> texts, Vector3 posOri, Vector3 pos, List<float> duratime, List<bool> isSticker)
	{
		this.id = id;
		this.texts = texts;
		this.pos = pos;
		this.posOri = posOri;
		this.duratime = duratime;
		this.isSticker = isSticker;
	}
}
