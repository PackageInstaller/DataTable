using Newtonsoft.Json;

namespace ACT.Model;

public class NewbieConfig
{
	[JsonProperty("multiNumber")]
	public int MultiNumber { get; set; }

	[JsonProperty("multiDiscountPermyriad")]
	public int MultiDiscountPermyriad { get; set; }

	[JsonProperty("bigGuarantNum")]
	public int BigGuarantNum { get; set; }

	[JsonProperty("bigGuarantPool")]
	public int[] BigGuarantPool { get; set; }

	[JsonProperty("gachaDisplay")]
	public string GachaDisplay { get; set; }
}
