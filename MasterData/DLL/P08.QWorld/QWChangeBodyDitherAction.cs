public class QWChangeBodyDitherAction : QWAgentAction
{
	public QWBodyDitherChangeFunc showFunc;

	public float targetDither;

	public float ditherDuration;

	public QWChangeBodyDitherAction()
		: base(E_Type.BodyDither)
	{
	}
}
