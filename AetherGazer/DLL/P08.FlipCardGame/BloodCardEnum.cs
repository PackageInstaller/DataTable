public class BloodCardEnum
{
	public enum GameStatus
	{
		PREPARE,
		START,
		DETERMINEORDER,
		DRAW_INITIAL_HAND,
		SHUFFLEHAND,
		PLAYERROUND,
		MIDPAUSE,
		ENEMYROUND,
		GAMEOVER
	}

	public enum PlaceType
	{
		HAND,
		BOARD,
		DECK,
		CHANGE
	}

	public enum EffectType
	{
		NONE,
		CHANGEPOWER,
		ADDCARD,
		BREAK,
		ADDSELFPOWERBYOTHER,
		ADDSELFPOWERBYCOVER
	}

	public enum EffectTriggerTimeType
	{
		BEFOREPLACE = 1,
		AFTERPLACE = 2,
		ONBOARD = 11
	}

	public enum EffectTargetType
	{
		SELF,
		ENEMY,
		ALL
	}

	public enum PlayerState
	{
		NORMAL,
		BUFFED,
		DEBUFFED
	}

	public enum TurnPhase
	{
		DRAW_PHASE,
		THINK_PHASE,
		RESOLUTION_PHASE,
		END_PHASE
	}

	public enum MatchResolution
	{
		TIE,
		PRE,
		AFT
	}

	public enum CardRarity
	{
		COMMON = 0,
		GOLD = 99
	}

	public enum PlayerAction
	{
		SELECT_INITIAL_HAND,
		CONFIRM_SELECTION,
		CANCEL_SELECTION,
		END_TURN
	}

	public enum GameMode
	{
		SINGLEPLAYER,
		MULTIPLAYER
	}

	public enum PlayerRole
	{
		SELF,
		ENEMY,
		SYSTEM
	}

	public enum PlayerPriority
	{
		FIRST_PLAYER,
		SECOND_PLAYER
	}

	public enum OccupationStatus
	{
		NEUTRAL,
		OWNED,
		ENEMY_OWNED
	}

	public enum GridPositionRelation
	{
		DIRECT_NEIGHBOR,
		DIAGONAL_NEIGHBOR
	}

	public enum EffectDisplay
	{

	}

	public enum CardStatus
	{
		IN_DECK,
		IN_HAND,
		ON_FIELD,
		DESTROYED
	}

	public enum PlacementType
	{
		REGULAR = 1,
		OVERLAY
	}

	public enum PlacementRule
	{
		STANDARD,
		OVERLAY
	}

	public enum PreviewCardRule
	{
		SHOW_EFFECT,
		HIGHLIGHT_EFFECT
	}

	public enum ControlPointStatus
	{
		NEUTRAL,
		CONTROLLED
	}

	public enum PlayEffectType
	{
		SELFPLACE,
		ENEMYPLACE,
		SELFGOLDPLACE,
		ENEMYGOLDPLACE,
		BUFFENEMY,
		BUFFSELF,
		BREAK
	}
}
