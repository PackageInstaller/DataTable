using GameFramework;

namespace Ase;

public class SDKPayResult : IReference
{
	private string orderId;

	private string orderSign;

	private int error;

	public string OrderId => orderId;

	public string OrderSign => orderSign;

	public int Error => error;

	public static SDKPayResult Create(MakePayOrderResponse makePayOrderResponse)
	{
		SDKPayResult sDKPayResult = ReferencePool.Acquire<SDKPayResult>();
		sDKPayResult.orderId = makePayOrderResponse.GameOrderId;
		sDKPayResult.orderSign = makePayOrderResponse.OrderSign;
		sDKPayResult.error = makePayOrderResponse.Error;
		return sDKPayResult;
	}

	public static SDKPayResult Create(int error)
	{
		SDKPayResult sDKPayResult = ReferencePool.Acquire<SDKPayResult>();
		sDKPayResult.error = error;
		return sDKPayResult;
	}

	public void Clear()
	{
		orderId = string.Empty;
		orderSign = string.Empty;
		error = 0;
	}
}
