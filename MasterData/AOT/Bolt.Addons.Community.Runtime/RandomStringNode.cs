using System;
using System.Linq;
using Unity.VisualScripting;

[TypeIcon(typeof(string))]
[UnitTitle("Random String")]
[UnitCategory("Community\\Utility\\string")]
public class RandomStringNode : Unit
{
	[DoNotSerialize]
	public ValueOutput Output;

	protected override void Definition()
	{
		Output = ValueOutput("Output", GetRandomString);
	}

	public string GetRandomString(Flow flow)
	{
		Random random = new Random();
		return new string((from s in Enumerable.Repeat("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", 10)
			select s[random.Next(s.Length)]).ToArray());
	}
}
