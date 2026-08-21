using UnityEngine;

namespace Ase;

public class MultiMatchGamerViewModel : OptionBase
{
	private long _gamerUid;

	private int _gamerImg;

	private int _gamerFrame;

	private bool _gamerConfirm;

	private bool _gamerCancel;

	private Color _color;

	public int GamerImg => _gamerImg;

	public long GamerUid => _gamerUid;

	public bool GamerCancel
	{
		get
		{
			return _gamerCancel;
		}
		private set
		{
			Set(ref _gamerCancel, value, "GamerCancel");
		}
	}

	public bool GamerConfirm
	{
		get
		{
			return _gamerConfirm;
		}
		private set
		{
			Set(ref _gamerConfirm, value, "GamerConfirm");
		}
	}

	public Color Color
	{
		get
		{
			return _color;
		}
		private set
		{
			Set(ref _color, value, "Color");
		}
	}

	public MultiMatchGamerViewModel()
	{
	}

	public MultiMatchGamerViewModel(OptionBase paren, int icon, long uid)
	{
		parent = paren;
		_gamerUid = uid;
		_gamerImg = icon;
		_gamerConfirm = false;
		_gamerCancel = false;
		_color = Color.gray;
	}

	public void SetOpt(int opt)
	{
		switch (opt)
		{
		case 1:
			GamerConfirm = true;
			break;
		case 2:
			GamerCancel = true;
			break;
		}
		Color = Color.white;
	}
}
