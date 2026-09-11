using System;
using System.Collections.Generic;
using UnityEngine;

public class TweenManager : MonoBehaviour
{
	public List<TweenList> tweenS = new List<TweenList>(32);

	public Action<string> luaPlayFuc;
}
