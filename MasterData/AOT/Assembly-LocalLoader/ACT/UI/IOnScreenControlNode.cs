using System;

namespace ACT.UI;

internal interface IOnScreenControlNode
{
	Type ValueType { get; }

	string ControlPath { get; set; }
}
