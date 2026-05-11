using System.Text;

namespace DNFBDmp {
	public class FBSBuilder {
		enum BuildingState {
			FINISHED = 0,
			BUILDING_TABLE,
			BUILDING_ENUM
		};

		private StringBuilder builder;
		private BuildingState state;
		private bool firstEnumDone;

		public FBSBuilder(StringBuilder builder) {
			this.builder = builder;
			this.state = BuildingState.FINISHED;
			this.firstEnumDone = false;
		}

		public FBSBuilder() {
			this.builder = new StringBuilder();
			this.state = BuildingState.FINISHED;
			this.firstEnumDone = false;
		}

		// Table functions

		public FBSBuilder beginTable(string name) {
			if (this.state != BuildingState.FINISHED)
				throw new Exception("Invalid FBSBuilder State");
			this.state = BuildingState.BUILDING_TABLE;

			this.builder.AppendLine($"table {name} {{");

			return this;
		}

	public FBSBuilder addTableField(string name, string type) {
		if (this.state != BuildingState.BUILDING_TABLE)
			throw new Exception("Invalid FBSBuilder State");

		this.builder.AppendLine($"  {name}: {type};");

		return this;
	}

	public FBSBuilder addTableArrayField(string name, string type) {
		if (this.state != BuildingState.BUILDING_TABLE)
			throw new Exception("Invalid FBSBuilder State");

		this.builder.AppendLine($"  {name}: [{type}];");

		return this;
	}

		public FBSBuilder endTable() {
			if (this.state != BuildingState.BUILDING_TABLE)
				throw new Exception("Invalid FBSBuilder State");
			this.state = BuildingState.FINISHED;

			this.builder.AppendLine("}\n");

			return this;
		}

		// Enum functions

		public FBSBuilder beginEnum(string name, string type) {
			if (this.state != BuildingState.FINISHED)
				throw new Exception("Invalid FBSBuilder State");
			this.state = BuildingState.BUILDING_ENUM;
			this.firstEnumDone = false;

			this.builder.AppendLine($"enum {name} : {type} {{");

			return this;
		}

	public FBSBuilder addEnumValue(string name, object? value=null) {
		if (this.state != BuildingState.BUILDING_ENUM)
			throw new Exception("Invalid FBSBuilder State");

		if (this.firstEnumDone)
			this.builder.AppendLine(",");
		if (value != null)
			this.builder.Append($"  {name} = {value}");
		else
			this.builder.Append($"  {name}");

		if (!this.firstEnumDone)
			this.firstEnumDone = true;

		return this;
	}

		public FBSBuilder endEnum() {
			if (this.state != BuildingState.BUILDING_ENUM)
				throw new Exception("Invalid FBSBuilder State");
			this.state = BuildingState.FINISHED;

			this.builder.AppendLine();
			this.builder.AppendLine("}");

			return this;
		}

		// Finishing functions

		public string build() {
			if (this.state != BuildingState.FINISHED)
				throw new Exception("Invalid FBSBuilder State");
			return this.builder.ToString();
		}
	}
}