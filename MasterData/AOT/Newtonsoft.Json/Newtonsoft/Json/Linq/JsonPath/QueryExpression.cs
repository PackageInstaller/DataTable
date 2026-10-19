namespace Newtonsoft.Json.Linq.JsonPath;

internal abstract class QueryExpression
{
	internal QueryOperator Operator;

	public QueryExpression(QueryOperator @operator)
	{
		Operator = @operator;
	}

	public abstract bool IsMatch(JToken root, JToken t, JsonSelectSettings? settings);
}
