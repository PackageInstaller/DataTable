public interface ISummerRaceBuildProfileProvider
{
	SummerRaceBuildProfile GetBuildProfile();

	SummerRaceBuildRating GetBuildRating();

	SummerRaceBuildBlueprint ExportRuntimeBlueprint();
}
