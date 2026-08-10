return {
	Play102081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102081001
		arg_1_1.duration_ = 8.27

		local var_1_0 = {
			ja = 8.266,
			ko = 5.733,
			zh = 6.333,
			en = 5.533
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play102081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "effect"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_4 = 0
			local var_4_5 = 1

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_6 = "play"
				local var_4_7 = "effect"

				arg_1_1:AudioAction(var_4_6, var_4_7, "se_story", "se_story_robot_short", "")
			end

			local var_4_8 = 0
			local var_4_9 = 1

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_10 = "play"
				local var_4_11 = "effect"

				arg_1_1:AudioAction(var_4_10, var_4_11, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_12 = "2022_tpose"

			if arg_1_1.actors_[var_4_12] == nil then
				local var_4_13 = Asset.Load("Char/" .. "2022_tpose")

				if not isNil(var_4_13) then
					local var_4_14 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_1_1.stage_.transform)

					var_4_14.name = var_4_12
					var_4_14.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_12] = var_4_14

					local var_4_15 = var_4_14:GetComponentInChildren(typeof(CharacterEffect))

					var_4_15.enabled = true

					local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_14, typeof(DynamicBoneHelper))

					if var_4_16 then
						var_4_16:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_15.transform, false)

					arg_1_1.var_[var_4_12 .. "Animator"] = var_4_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_12 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_12 .. "LipSync"] = var_4_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_17 = arg_1_1.actors_["2022_tpose"]
			local var_4_18 = 2

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect2022_tpose == nil then
				arg_1_1.var_.characterEffect2022_tpose = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_19 = 0.1

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 and not isNil(var_4_17) then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19

				if arg_1_1.var_.characterEffect2022_tpose and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect2022_tpose then
				arg_1_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_4_21 = "B02c"

			if arg_1_1.bgs_[var_4_21] == nil then
				local var_4_22 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_22:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_21)
				var_4_22.name = var_4_21
				var_4_22.transform.parent = arg_1_1.stage_.transform
				var_4_22.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_21] = var_4_22
			end

			local var_4_23 = arg_1_1.bgs_.B02c
			local var_4_24 = 0

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_25 = var_4_23:GetComponent("SpriteRenderer")

				if var_4_25 then
					arg_1_1.var_.alphaOldValueB02c = var_4_25.color.a
					arg_1_1.var_.alphaMatValueB02c = var_4_25
				end

				arg_1_1.var_.alphaOldValueB02c = 0
			end

			local var_4_26 = 1.5

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_26 then
				local var_4_27 = (arg_1_1.time_ - var_4_24) / var_4_26
				local var_4_28 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02c, 1, var_4_27)

				if arg_1_1.var_.alphaMatValueB02c then
					local var_4_29 = arg_1_1.var_.alphaMatValueB02c.color

					var_4_29.a = var_4_28
					arg_1_1.var_.alphaMatValueB02c.color = var_4_29
				end
			end

			if arg_1_1.time_ >= var_4_24 + var_4_26 and arg_1_1.time_ < var_4_24 + var_4_26 + arg_4_0 and arg_1_1.var_.alphaMatValueB02c then
				local var_4_30 = arg_1_1.var_.alphaMatValueB02c
				local var_4_31 = var_4_30.color

				var_4_31.a = 1
				var_4_30.color = var_4_31
			end

			local var_4_32 = 0

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				local var_4_33 = manager.ui.mainCamera.transform.localPosition
				local var_4_34 = Vector3.New(0, 0, 10) + Vector3.New(var_4_33.x, var_4_33.y, 0)
				local var_4_35 = arg_1_1.bgs_.B02c

				var_4_35.transform.localPosition = var_4_34
				var_4_35.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_36 = var_4_35:GetComponent("SpriteRenderer")

				if var_4_36 and var_4_36.sprite then
					local var_4_37 = (var_4_35.transform.localPosition - var_4_33).z
					local var_4_38 = manager.ui.mainCameraCom_
					local var_4_39 = 2 * var_4_37 * Mathf.Tan(var_4_38.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_40 = var_4_39 * var_4_38.aspect
					local var_4_41 = var_4_36.sprite.bounds.size.x
					local var_4_42 = var_4_36.sprite.bounds.size.y
					local var_4_43 = var_4_40 / var_4_41
					local var_4_44 = var_4_39 / var_4_42
					local var_4_45 = var_4_44 < var_4_43 and var_4_43 or var_4_44

					var_4_35.transform.localScale = Vector3.New(var_4_45, var_4_45, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_46 = arg_1_1.actors_["2022_tpose"].transform
			local var_4_47 = 1.79999995231628

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				arg_1_1.var_.moveOldPos2022_tpose = var_4_46.localPosition

				local var_4_48 = GameObjectTools.GetOrAddComponent(var_4_46.gameObject, typeof(DynamicBoneHelper))

				if var_4_48 then
					var_4_48:EnableDynamicBone(false)
				end
			end

			local var_4_49 = 0.001

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_49 then
				local var_4_50 = (arg_1_1.time_ - var_4_47) / var_4_49
				local var_4_51 = Vector3.New(0, -0.55, -0.3)

				var_4_46.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2022_tpose, var_4_51, var_4_50)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_46.position

				var_4_46.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_46.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_46.localEulerAngles = var_4_53
			end

			if arg_1_1.time_ >= var_4_47 + var_4_49 and arg_1_1.time_ < var_4_47 + var_4_49 + arg_4_0 then
				var_4_46.localPosition = Vector3.New(0, -0.55, -0.3)

				local var_4_54 = manager.ui.mainCamera.transform.position - var_4_46.position

				var_4_46.forward = Vector3.New(var_4_54.x, var_4_54.y, var_4_54.z)

				local var_4_55 = var_4_46.localEulerAngles

				var_4_55.z = 0
				var_4_55.x = 0
				var_4_46.localEulerAngles = var_4_55

				local var_4_56 = GameObjectTools.GetOrAddComponent(var_4_46.gameObject, typeof(DynamicBoneHelper))

				if var_4_56 then
					var_4_56:EnableDynamicBone(true)
				end
			end

			local var_4_57 = 0

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_4_58 = 0

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_59 = 2

			if arg_1_1.time_ >= var_4_58 + var_4_59 and arg_1_1.time_ < var_4_58 + var_4_59 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2
			local var_4_61 = 0.375

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[29].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(102081001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 15
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081001", "story_v_out_102081.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_out_102081", "102081001", "story_v_out_102081.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_out_102081", "102081001", "story_v_out_102081.awb")

						arg_1_1:RecordAudio("102081001", var_4_70)
						arg_1_1:RecordAudio("102081001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102081", "102081001", "story_v_out_102081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102081", "102081001", "story_v_out_102081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_71 = var_4_60 + 0.3
			local var_4_72 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_71) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play102081002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 102081002
		arg_7_1.duration_ = 5.03

		local var_7_0 = {
			ja = 5.033,
			ko = 3.7,
			zh = 3.5,
			en = 3.666
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play102081003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				local var_10_2 = "play"
				local var_10_3 = "effect"

				arg_7_1:AudioAction(var_10_2, var_10_3, "se_story", "se_story_robot_short", "")
			end

			local var_10_4 = "2018_tpose"

			if arg_7_1.actors_[var_10_4] == nil then
				local var_10_5 = Asset.Load("Char/" .. "2018_tpose")

				if not isNil(var_10_5) then
					local var_10_6 = Object.Instantiate(Asset.Load("Char/" .. "2018_tpose"), arg_7_1.stage_.transform)

					var_10_6.name = var_10_4
					var_10_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_4] = var_10_6

					local var_10_7 = var_10_6:GetComponentInChildren(typeof(CharacterEffect))

					var_10_7.enabled = true

					local var_10_8 = GameObjectTools.GetOrAddComponent(var_10_6, typeof(DynamicBoneHelper))

					if var_10_8 then
						var_10_8:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_7.transform, false)

					arg_7_1.var_[var_10_4 .. "Animator"] = var_10_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_4 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_4 .. "LipSync"] = var_10_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_9 = arg_7_1.actors_["2018_tpose"]
			local var_10_10 = 0

			if var_10_10 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 and not isNil(var_10_9) and arg_7_1.var_.characterEffect2018_tpose == nil then
				arg_7_1.var_.characterEffect2018_tpose = var_10_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_11 = 0.1

			if var_10_10 <= arg_7_1.time_ and arg_7_1.time_ < var_10_10 + var_10_11 and not isNil(var_10_9) then
				local var_10_12 = (arg_7_1.time_ - var_10_10) / var_10_11

				if arg_7_1.var_.characterEffect2018_tpose and not isNil(var_10_9) then
					arg_7_1.var_.characterEffect2018_tpose.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_10 + var_10_11 and arg_7_1.time_ < var_10_10 + var_10_11 + arg_10_0 and not isNil(var_10_9) and arg_7_1.var_.characterEffect2018_tpose then
				arg_7_1.var_.characterEffect2018_tpose.fillFlat = false
			end

			local var_10_13 = arg_7_1.actors_["2022_tpose"]
			local var_10_14 = 0

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 and not isNil(var_10_13) and arg_7_1.var_.characterEffect2022_tpose == nil then
				arg_7_1.var_.characterEffect2022_tpose = var_10_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_15 = 0.1

			if var_10_14 <= arg_7_1.time_ and arg_7_1.time_ < var_10_14 + var_10_15 and not isNil(var_10_13) then
				local var_10_16 = (arg_7_1.time_ - var_10_14) / var_10_15

				if arg_7_1.var_.characterEffect2022_tpose and not isNil(var_10_13) then
					local var_10_17 = Mathf.Lerp(0, 0.5, var_10_16)

					arg_7_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_7_1.var_.characterEffect2022_tpose.fillRatio = var_10_17
				end
			end

			if arg_7_1.time_ >= var_10_14 + var_10_15 and arg_7_1.time_ < var_10_14 + var_10_15 + arg_10_0 and not isNil(var_10_13) and arg_7_1.var_.characterEffect2022_tpose then
				local var_10_18 = 0.5

				arg_7_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_7_1.var_.characterEffect2022_tpose.fillRatio = var_10_18
			end

			local var_10_19 = arg_7_1.actors_["2022_tpose"].transform
			local var_10_20 = 0

			if var_10_20 < arg_7_1.time_ and arg_7_1.time_ <= var_10_20 + arg_10_0 then
				arg_7_1.var_.moveOldPos2022_tpose = var_10_19.localPosition

				local var_10_21 = GameObjectTools.GetOrAddComponent(var_10_19.gameObject, typeof(DynamicBoneHelper))

				if var_10_21 then
					var_10_21:EnableDynamicBone(false)
				end
			end

			local var_10_22 = 0.001

			if var_10_20 <= arg_7_1.time_ and arg_7_1.time_ < var_10_20 + var_10_22 then
				local var_10_23 = (arg_7_1.time_ - var_10_20) / var_10_22
				local var_10_24 = Vector3.New(0, 100, 0)

				var_10_19.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2022_tpose, var_10_24, var_10_23)

				local var_10_25 = manager.ui.mainCamera.transform.position - var_10_19.position

				var_10_19.forward = Vector3.New(var_10_25.x, var_10_25.y, var_10_25.z)

				local var_10_26 = var_10_19.localEulerAngles

				var_10_26.z = 0
				var_10_26.x = 0
				var_10_19.localEulerAngles = var_10_26
			end

			if arg_7_1.time_ >= var_10_20 + var_10_22 and arg_7_1.time_ < var_10_20 + var_10_22 + arg_10_0 then
				var_10_19.localPosition = Vector3.New(0, 100, 0)

				local var_10_27 = manager.ui.mainCamera.transform.position - var_10_19.position

				var_10_19.forward = Vector3.New(var_10_27.x, var_10_27.y, var_10_27.z)

				local var_10_28 = var_10_19.localEulerAngles

				var_10_28.z = 0
				var_10_28.x = 0
				var_10_19.localEulerAngles = var_10_28

				local var_10_29 = GameObjectTools.GetOrAddComponent(var_10_19.gameObject, typeof(DynamicBoneHelper))

				if var_10_29 then
					var_10_29:EnableDynamicBone(true)
				end
			end

			local var_10_30 = arg_7_1.actors_["2018_tpose"].transform
			local var_10_31 = 0

			if var_10_31 < arg_7_1.time_ and arg_7_1.time_ <= var_10_31 + arg_10_0 then
				arg_7_1.var_.moveOldPos2018_tpose = var_10_30.localPosition

				local var_10_32 = GameObjectTools.GetOrAddComponent(var_10_30.gameObject, typeof(DynamicBoneHelper))

				if var_10_32 then
					var_10_32:EnableDynamicBone(false)
				end
			end

			local var_10_33 = 0.001

			if var_10_31 <= arg_7_1.time_ and arg_7_1.time_ < var_10_31 + var_10_33 then
				local var_10_34 = (arg_7_1.time_ - var_10_31) / var_10_33
				local var_10_35 = Vector3.New(0, -0.5, -0.7)

				var_10_30.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2018_tpose, var_10_35, var_10_34)

				local var_10_36 = manager.ui.mainCamera.transform.position - var_10_30.position

				var_10_30.forward = Vector3.New(var_10_36.x, var_10_36.y, var_10_36.z)

				local var_10_37 = var_10_30.localEulerAngles

				var_10_37.z = 0
				var_10_37.x = 0
				var_10_30.localEulerAngles = var_10_37
			end

			if arg_7_1.time_ >= var_10_31 + var_10_33 and arg_7_1.time_ < var_10_31 + var_10_33 + arg_10_0 then
				var_10_30.localPosition = Vector3.New(0, -0.5, -0.7)

				local var_10_38 = manager.ui.mainCamera.transform.position - var_10_30.position

				var_10_30.forward = Vector3.New(var_10_38.x, var_10_38.y, var_10_38.z)

				local var_10_39 = var_10_30.localEulerAngles

				var_10_39.z = 0
				var_10_39.x = 0
				var_10_30.localEulerAngles = var_10_39

				local var_10_40 = GameObjectTools.GetOrAddComponent(var_10_30.gameObject, typeof(DynamicBoneHelper))

				if var_10_40 then
					var_10_40:EnableDynamicBone(true)
				end
			end

			local var_10_41 = 0

			if var_10_41 < arg_7_1.time_ and arg_7_1.time_ <= var_10_41 + arg_10_0 then
				arg_7_1:PlayTimeline("2018_tpose", "StoryTimeline/CharAction/story2018/story2018action/2018action1_1")
			end

			local var_10_42 = 0
			local var_10_43 = 0.3

			if var_10_42 < arg_7_1.time_ and arg_7_1.time_ <= var_10_42 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_44 = arg_7_1:FormatText(StoryNameCfg[29].name)

				arg_7_1.leftNameTxt_.text = var_10_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_45 = arg_7_1:GetWordFromCfg(102081002)
				local var_10_46 = arg_7_1:FormatText(var_10_45.content)

				arg_7_1.text_.text = var_10_46

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_47 = 12
				local var_10_48 = utf8.len(var_10_46)
				local var_10_49 = var_10_47 <= 0 and var_10_43 or var_10_43 * (var_10_48 / var_10_47)

				if var_10_49 > 0 and var_10_43 < var_10_49 then
					arg_7_1.talkMaxDuration = var_10_49

					if var_10_49 + var_10_42 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_49 + var_10_42
					end
				end

				arg_7_1.text_.text = var_10_46
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081002", "story_v_out_102081.awb") ~= 0 then
					local var_10_50 = manager.audio:GetVoiceLength("story_v_out_102081", "102081002", "story_v_out_102081.awb") / 1000

					if var_10_50 + var_10_42 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_50 + var_10_42
					end

					if var_10_45.prefab_name ~= "" and arg_7_1.actors_[var_10_45.prefab_name] ~= nil then
						local var_10_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_45.prefab_name].transform, "story_v_out_102081", "102081002", "story_v_out_102081.awb")

						arg_7_1:RecordAudio("102081002", var_10_51)
						arg_7_1:RecordAudio("102081002", var_10_51)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_102081", "102081002", "story_v_out_102081.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_102081", "102081002", "story_v_out_102081.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_52 = math.max(var_10_43, arg_7_1.talkMaxDuration)

			if var_10_42 <= arg_7_1.time_ and arg_7_1.time_ < var_10_42 + var_10_52 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_42) / var_10_52

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_42 + var_10_52 and arg_7_1.time_ < var_10_42 + var_10_52 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play102081003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 102081003
		arg_11_1.duration_ = 2

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play102081004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = "1011ui_story"

			if arg_11_1.actors_[var_14_0] == nil then
				local var_14_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_14_1) then
					local var_14_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_11_1.stage_.transform)

					var_14_2.name = var_14_0
					var_14_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_11_1.actors_[var_14_0] = var_14_2

					local var_14_3 = var_14_2:GetComponentInChildren(typeof(CharacterEffect))

					var_14_3.enabled = true

					local var_14_4 = GameObjectTools.GetOrAddComponent(var_14_2, typeof(DynamicBoneHelper))

					if var_14_4 then
						var_14_4:EnableDynamicBone(false)
					end

					arg_11_1:ShowWeapon(var_14_3.transform, false)

					arg_11_1.var_[var_14_0 .. "Animator"] = var_14_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_11_1.var_[var_14_0 .. "Animator"].applyRootMotion = true
					arg_11_1.var_[var_14_0 .. "LipSync"] = var_14_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_14_5 = arg_11_1.actors_["1011ui_story"]
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1011ui_story == nil then
				arg_11_1.var_.characterEffect1011ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_7 = 0.1

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 and not isNil(var_14_5) then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7

				if arg_11_1.var_.characterEffect1011ui_story and not isNil(var_14_5) then
					arg_11_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1011ui_story then
				arg_11_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_14_9 = arg_11_1.actors_["2018_tpose"]
			local var_14_10 = 0

			if var_14_10 < arg_11_1.time_ and arg_11_1.time_ <= var_14_10 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect2018_tpose == nil then
				arg_11_1.var_.characterEffect2018_tpose = var_14_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_11 = 0.1

			if var_14_10 <= arg_11_1.time_ and arg_11_1.time_ < var_14_10 + var_14_11 and not isNil(var_14_9) then
				local var_14_12 = (arg_11_1.time_ - var_14_10) / var_14_11

				if arg_11_1.var_.characterEffect2018_tpose and not isNil(var_14_9) then
					local var_14_13 = Mathf.Lerp(0, 0.5, var_14_12)

					arg_11_1.var_.characterEffect2018_tpose.fillFlat = true
					arg_11_1.var_.characterEffect2018_tpose.fillRatio = var_14_13
				end
			end

			if arg_11_1.time_ >= var_14_10 + var_14_11 and arg_11_1.time_ < var_14_10 + var_14_11 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect2018_tpose then
				local var_14_14 = 0.5

				arg_11_1.var_.characterEffect2018_tpose.fillFlat = true
				arg_11_1.var_.characterEffect2018_tpose.fillRatio = var_14_14
			end

			local var_14_15 = arg_11_1.actors_["2018_tpose"].transform
			local var_14_16 = 0

			if var_14_16 < arg_11_1.time_ and arg_11_1.time_ <= var_14_16 + arg_14_0 then
				arg_11_1.var_.moveOldPos2018_tpose = var_14_15.localPosition

				local var_14_17 = GameObjectTools.GetOrAddComponent(var_14_15.gameObject, typeof(DynamicBoneHelper))

				if var_14_17 then
					var_14_17:EnableDynamicBone(false)
				end
			end

			local var_14_18 = 0.001

			if var_14_16 <= arg_11_1.time_ and arg_11_1.time_ < var_14_16 + var_14_18 then
				local var_14_19 = (arg_11_1.time_ - var_14_16) / var_14_18
				local var_14_20 = Vector3.New(0, 100, 0)

				var_14_15.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2018_tpose, var_14_20, var_14_19)

				local var_14_21 = manager.ui.mainCamera.transform.position - var_14_15.position

				var_14_15.forward = Vector3.New(var_14_21.x, var_14_21.y, var_14_21.z)

				local var_14_22 = var_14_15.localEulerAngles

				var_14_22.z = 0
				var_14_22.x = 0
				var_14_15.localEulerAngles = var_14_22
			end

			if arg_11_1.time_ >= var_14_16 + var_14_18 and arg_11_1.time_ < var_14_16 + var_14_18 + arg_14_0 then
				var_14_15.localPosition = Vector3.New(0, 100, 0)

				local var_14_23 = manager.ui.mainCamera.transform.position - var_14_15.position

				var_14_15.forward = Vector3.New(var_14_23.x, var_14_23.y, var_14_23.z)

				local var_14_24 = var_14_15.localEulerAngles

				var_14_24.z = 0
				var_14_24.x = 0
				var_14_15.localEulerAngles = var_14_24

				local var_14_25 = GameObjectTools.GetOrAddComponent(var_14_15.gameObject, typeof(DynamicBoneHelper))

				if var_14_25 then
					var_14_25:EnableDynamicBone(true)
				end
			end

			local var_14_26 = arg_11_1.actors_["1011ui_story"].transform
			local var_14_27 = 0

			if var_14_27 < arg_11_1.time_ and arg_11_1.time_ <= var_14_27 + arg_14_0 then
				arg_11_1.var_.moveOldPos1011ui_story = var_14_26.localPosition
			end

			local var_14_28 = 0.001

			if var_14_27 <= arg_11_1.time_ and arg_11_1.time_ < var_14_27 + var_14_28 then
				local var_14_29 = (arg_11_1.time_ - var_14_27) / var_14_28
				local var_14_30 = Vector3.New(-0.7, -0.71, -6)

				var_14_26.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1011ui_story, var_14_30, var_14_29)

				local var_14_31 = manager.ui.mainCamera.transform.position - var_14_26.position

				var_14_26.forward = Vector3.New(var_14_31.x, var_14_31.y, var_14_31.z)

				local var_14_32 = var_14_26.localEulerAngles

				var_14_32.z = 0
				var_14_32.x = 0
				var_14_26.localEulerAngles = var_14_32
			end

			if arg_11_1.time_ >= var_14_27 + var_14_28 and arg_11_1.time_ < var_14_27 + var_14_28 + arg_14_0 then
				var_14_26.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_14_33 = manager.ui.mainCamera.transform.position - var_14_26.position

				var_14_26.forward = Vector3.New(var_14_33.x, var_14_33.y, var_14_33.z)

				local var_14_34 = var_14_26.localEulerAngles

				var_14_34.z = 0
				var_14_34.x = 0
				var_14_26.localEulerAngles = var_14_34
			end

			local var_14_35 = 0

			if var_14_35 < arg_11_1.time_ and arg_11_1.time_ <= var_14_35 + arg_14_0 then
				arg_11_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_14_36 = 0

			if var_14_36 < arg_11_1.time_ and arg_11_1.time_ <= var_14_36 + arg_14_0 then
				arg_11_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_14_37 = 0
			local var_14_38 = 0.1

			if var_14_37 < arg_11_1.time_ and arg_11_1.time_ <= var_14_37 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_39 = arg_11_1:FormatText(StoryNameCfg[37].name)

				arg_11_1.leftNameTxt_.text = var_14_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_40 = arg_11_1:GetWordFromCfg(102081003)
				local var_14_41 = arg_11_1:FormatText(var_14_40.content)

				arg_11_1.text_.text = var_14_41

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_42 = 4
				local var_14_43 = utf8.len(var_14_41)
				local var_14_44 = var_14_42 <= 0 and var_14_38 or var_14_38 * (var_14_43 / var_14_42)

				if var_14_44 > 0 and var_14_38 < var_14_44 then
					arg_11_1.talkMaxDuration = var_14_44

					if var_14_44 + var_14_37 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_44 + var_14_37
					end
				end

				arg_11_1.text_.text = var_14_41
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081003", "story_v_out_102081.awb") ~= 0 then
					local var_14_45 = manager.audio:GetVoiceLength("story_v_out_102081", "102081003", "story_v_out_102081.awb") / 1000

					if var_14_45 + var_14_37 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_45 + var_14_37
					end

					if var_14_40.prefab_name ~= "" and arg_11_1.actors_[var_14_40.prefab_name] ~= nil then
						local var_14_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_40.prefab_name].transform, "story_v_out_102081", "102081003", "story_v_out_102081.awb")

						arg_11_1:RecordAudio("102081003", var_14_46)
						arg_11_1:RecordAudio("102081003", var_14_46)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_102081", "102081003", "story_v_out_102081.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_102081", "102081003", "story_v_out_102081.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_47 = math.max(var_14_38, arg_11_1.talkMaxDuration)

			if var_14_37 <= arg_11_1.time_ and arg_11_1.time_ < var_14_37 + var_14_47 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_37) / var_14_47

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_37 + var_14_47 and arg_11_1.time_ < var_14_37 + var_14_47 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2018_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play102081004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 102081004
		arg_15_1.duration_ = 2.7

		local var_15_0 = {
			ja = 2.2,
			ko = 2.3,
			zh = 2.7,
			en = 2.566
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play102081005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "1084ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["1084ui_story"]
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = var_18_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_7 = 0.1

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 and not isNil(var_18_5) then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7

				if arg_15_1.var_.characterEffect1084ui_story and not isNil(var_18_5) then
					arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 and not isNil(var_18_5) and arg_15_1.var_.characterEffect1084ui_story then
				arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_18_9 = arg_15_1.actors_["1011ui_story"]
			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1011ui_story == nil then
				arg_15_1.var_.characterEffect1011ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.1

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 and not isNil(var_18_9) then
				local var_18_12 = (arg_15_1.time_ - var_18_10) / var_18_11

				if arg_15_1.var_.characterEffect1011ui_story and not isNil(var_18_9) then
					local var_18_13 = Mathf.Lerp(0, 0.5, var_18_12)

					arg_15_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1011ui_story.fillRatio = var_18_13
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1011ui_story then
				local var_18_14 = 0.5

				arg_15_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1011ui_story.fillRatio = var_18_14
			end

			local var_18_15 = arg_15_1.actors_["1084ui_story"].transform
			local var_18_16 = 0

			if var_18_16 < arg_15_1.time_ and arg_15_1.time_ <= var_18_16 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = var_18_15.localPosition
			end

			local var_18_17 = 0.001

			if var_18_16 <= arg_15_1.time_ and arg_15_1.time_ < var_18_16 + var_18_17 then
				local var_18_18 = (arg_15_1.time_ - var_18_16) / var_18_17
				local var_18_19 = Vector3.New(0.7, -0.97, -6)

				var_18_15.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, var_18_19, var_18_18)

				local var_18_20 = manager.ui.mainCamera.transform.position - var_18_15.position

				var_18_15.forward = Vector3.New(var_18_20.x, var_18_20.y, var_18_20.z)

				local var_18_21 = var_18_15.localEulerAngles

				var_18_21.z = 0
				var_18_21.x = 0
				var_18_15.localEulerAngles = var_18_21
			end

			if arg_15_1.time_ >= var_18_16 + var_18_17 and arg_15_1.time_ < var_18_16 + var_18_17 + arg_18_0 then
				var_18_15.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_18_22 = manager.ui.mainCamera.transform.position - var_18_15.position

				var_18_15.forward = Vector3.New(var_18_22.x, var_18_22.y, var_18_22.z)

				local var_18_23 = var_18_15.localEulerAngles

				var_18_23.z = 0
				var_18_23.x = 0
				var_18_15.localEulerAngles = var_18_23
			end

			local var_18_24 = 0

			if var_18_24 < arg_15_1.time_ and arg_15_1.time_ <= var_18_24 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_18_25 = 0

			if var_18_25 < arg_15_1.time_ and arg_15_1.time_ <= var_18_25 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_18_26 = 0
			local var_18_27 = 0.25

			if var_18_26 < arg_15_1.time_ and arg_15_1.time_ <= var_18_26 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_28 = arg_15_1:FormatText(StoryNameCfg[6].name)

				arg_15_1.leftNameTxt_.text = var_18_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_29 = arg_15_1:GetWordFromCfg(102081004)
				local var_18_30 = arg_15_1:FormatText(var_18_29.content)

				arg_15_1.text_.text = var_18_30

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_31 = 10
				local var_18_32 = utf8.len(var_18_30)
				local var_18_33 = var_18_31 <= 0 and var_18_27 or var_18_27 * (var_18_32 / var_18_31)

				if var_18_33 > 0 and var_18_27 < var_18_33 then
					arg_15_1.talkMaxDuration = var_18_33

					if var_18_33 + var_18_26 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_33 + var_18_26
					end
				end

				arg_15_1.text_.text = var_18_30
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081004", "story_v_out_102081.awb") ~= 0 then
					local var_18_34 = manager.audio:GetVoiceLength("story_v_out_102081", "102081004", "story_v_out_102081.awb") / 1000

					if var_18_34 + var_18_26 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_34 + var_18_26
					end

					if var_18_29.prefab_name ~= "" and arg_15_1.actors_[var_18_29.prefab_name] ~= nil then
						local var_18_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_29.prefab_name].transform, "story_v_out_102081", "102081004", "story_v_out_102081.awb")

						arg_15_1:RecordAudio("102081004", var_18_35)
						arg_15_1:RecordAudio("102081004", var_18_35)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_102081", "102081004", "story_v_out_102081.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_102081", "102081004", "story_v_out_102081.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_36 = math.max(var_18_27, arg_15_1.talkMaxDuration)

			if var_18_26 <= arg_15_1.time_ and arg_15_1.time_ < var_18_26 + var_18_36 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_26) / var_18_36

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_26 + var_18_36 and arg_15_1.time_ < var_18_26 + var_18_36 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play102081005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 102081005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play102081006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1084ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.1

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1084ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1084ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1084ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1084ui_story.fillRatio = var_22_5
			end

			local var_22_6 = arg_19_1.actors_["1084ui_story"].transform
			local var_22_7 = 0

			if var_22_7 < arg_19_1.time_ and arg_19_1.time_ <= var_22_7 + arg_22_0 then
				arg_19_1.var_.moveOldPos1084ui_story = var_22_6.localPosition
			end

			local var_22_8 = 0.001

			if var_22_7 <= arg_19_1.time_ and arg_19_1.time_ < var_22_7 + var_22_8 then
				local var_22_9 = (arg_19_1.time_ - var_22_7) / var_22_8
				local var_22_10 = Vector3.New(0, 100, 0)

				var_22_6.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1084ui_story, var_22_10, var_22_9)

				local var_22_11 = manager.ui.mainCamera.transform.position - var_22_6.position

				var_22_6.forward = Vector3.New(var_22_11.x, var_22_11.y, var_22_11.z)

				local var_22_12 = var_22_6.localEulerAngles

				var_22_12.z = 0
				var_22_12.x = 0
				var_22_6.localEulerAngles = var_22_12
			end

			if arg_19_1.time_ >= var_22_7 + var_22_8 and arg_19_1.time_ < var_22_7 + var_22_8 + arg_22_0 then
				var_22_6.localPosition = Vector3.New(0, 100, 0)

				local var_22_13 = manager.ui.mainCamera.transform.position - var_22_6.position

				var_22_6.forward = Vector3.New(var_22_13.x, var_22_13.y, var_22_13.z)

				local var_22_14 = var_22_6.localEulerAngles

				var_22_14.z = 0
				var_22_14.x = 0
				var_22_6.localEulerAngles = var_22_14
			end

			local var_22_15 = arg_19_1.actors_["1011ui_story"].transform
			local var_22_16 = 0

			if var_22_16 < arg_19_1.time_ and arg_19_1.time_ <= var_22_16 + arg_22_0 then
				arg_19_1.var_.moveOldPos1011ui_story = var_22_15.localPosition
			end

			local var_22_17 = 0.001

			if var_22_16 <= arg_19_1.time_ and arg_19_1.time_ < var_22_16 + var_22_17 then
				local var_22_18 = (arg_19_1.time_ - var_22_16) / var_22_17
				local var_22_19 = Vector3.New(0, 100, 0)

				var_22_15.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1011ui_story, var_22_19, var_22_18)

				local var_22_20 = manager.ui.mainCamera.transform.position - var_22_15.position

				var_22_15.forward = Vector3.New(var_22_20.x, var_22_20.y, var_22_20.z)

				local var_22_21 = var_22_15.localEulerAngles

				var_22_21.z = 0
				var_22_21.x = 0
				var_22_15.localEulerAngles = var_22_21
			end

			if arg_19_1.time_ >= var_22_16 + var_22_17 and arg_19_1.time_ < var_22_16 + var_22_17 + arg_22_0 then
				var_22_15.localPosition = Vector3.New(0, 100, 0)

				local var_22_22 = manager.ui.mainCamera.transform.position - var_22_15.position

				var_22_15.forward = Vector3.New(var_22_22.x, var_22_22.y, var_22_22.z)

				local var_22_23 = var_22_15.localEulerAngles

				var_22_23.z = 0
				var_22_23.x = 0
				var_22_15.localEulerAngles = var_22_23
			end

			local var_22_24 = "1019ui_story"

			if arg_19_1.actors_[var_22_24] == nil then
				local var_22_25 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_22_25) then
					local var_22_26 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_19_1.stage_.transform)

					var_22_26.name = var_22_24
					var_22_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_24] = var_22_26

					local var_22_27 = var_22_26:GetComponentInChildren(typeof(CharacterEffect))

					var_22_27.enabled = true

					local var_22_28 = GameObjectTools.GetOrAddComponent(var_22_26, typeof(DynamicBoneHelper))

					if var_22_28 then
						var_22_28:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_27.transform, false)

					arg_19_1.var_[var_22_24 .. "Animator"] = var_22_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_24 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_24 .. "LipSync"] = var_22_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_29 = 0

			if var_22_29 < arg_19_1.time_ and arg_19_1.time_ <= var_22_29 + arg_22_0 then
				arg_19_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_22_30 = 0
			local var_22_31 = 1

			if var_22_30 < arg_19_1.time_ and arg_19_1.time_ <= var_22_30 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_32 = arg_19_1:GetWordFromCfg(102081005)
				local var_22_33 = arg_19_1:FormatText(var_22_32.content)

				arg_19_1.text_.text = var_22_33

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_34 = 40
				local var_22_35 = utf8.len(var_22_33)
				local var_22_36 = var_22_34 <= 0 and var_22_31 or var_22_31 * (var_22_35 / var_22_34)

				if var_22_36 > 0 and var_22_31 < var_22_36 then
					arg_19_1.talkMaxDuration = var_22_36

					if var_22_36 + var_22_30 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_36 + var_22_30
					end
				end

				arg_19_1.text_.text = var_22_33
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_37 = math.max(var_22_31, arg_19_1.talkMaxDuration)

			if var_22_30 <= arg_19_1.time_ and arg_19_1.time_ < var_22_30 + var_22_37 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_30) / var_22_37

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_30 + var_22_37 and arg_19_1.time_ < var_22_30 + var_22_37 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play102081006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 102081006
		arg_23_1.duration_ = 5.2

		local var_23_0 = {
			ja = 5.2,
			ko = 4.1,
			zh = 3.866,
			en = 4.3
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play102081007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1019ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1019ui_story == nil then
				arg_23_1.var_.characterEffect1019ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.1

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1019ui_story and not isNil(var_26_0) then
					arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1019ui_story then
				arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_26_4 = arg_23_1.actors_["1019ui_story"].transform
			local var_26_5 = 0

			if var_26_5 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.var_.moveOldPos1019ui_story = var_26_4.localPosition
			end

			local var_26_6 = 0.001

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_6 then
				local var_26_7 = (arg_23_1.time_ - var_26_5) / var_26_6
				local var_26_8 = Vector3.New(-0.7, -1.08, -5.9)

				var_26_4.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1019ui_story, var_26_8, var_26_7)

				local var_26_9 = manager.ui.mainCamera.transform.position - var_26_4.position

				var_26_4.forward = Vector3.New(var_26_9.x, var_26_9.y, var_26_9.z)

				local var_26_10 = var_26_4.localEulerAngles

				var_26_10.z = 0
				var_26_10.x = 0
				var_26_4.localEulerAngles = var_26_10
			end

			if arg_23_1.time_ >= var_26_5 + var_26_6 and arg_23_1.time_ < var_26_5 + var_26_6 + arg_26_0 then
				var_26_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_26_11 = manager.ui.mainCamera.transform.position - var_26_4.position

				var_26_4.forward = Vector3.New(var_26_11.x, var_26_11.y, var_26_11.z)

				local var_26_12 = var_26_4.localEulerAngles

				var_26_12.z = 0
				var_26_12.x = 0
				var_26_4.localEulerAngles = var_26_12
			end

			local var_26_13 = 0

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_26_14 = 0
			local var_26_15 = 0.525

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_16 = arg_23_1:FormatText(StoryNameCfg[13].name)

				arg_23_1.leftNameTxt_.text = var_26_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_17 = arg_23_1:GetWordFromCfg(102081006)
				local var_26_18 = arg_23_1:FormatText(var_26_17.content)

				arg_23_1.text_.text = var_26_18

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_19 = 21
				local var_26_20 = utf8.len(var_26_18)
				local var_26_21 = var_26_19 <= 0 and var_26_15 or var_26_15 * (var_26_20 / var_26_19)

				if var_26_21 > 0 and var_26_15 < var_26_21 then
					arg_23_1.talkMaxDuration = var_26_21

					if var_26_21 + var_26_14 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_21 + var_26_14
					end
				end

				arg_23_1.text_.text = var_26_18
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081006", "story_v_out_102081.awb") ~= 0 then
					local var_26_22 = manager.audio:GetVoiceLength("story_v_out_102081", "102081006", "story_v_out_102081.awb") / 1000

					if var_26_22 + var_26_14 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_22 + var_26_14
					end

					if var_26_17.prefab_name ~= "" and arg_23_1.actors_[var_26_17.prefab_name] ~= nil then
						local var_26_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_17.prefab_name].transform, "story_v_out_102081", "102081006", "story_v_out_102081.awb")

						arg_23_1:RecordAudio("102081006", var_26_23)
						arg_23_1:RecordAudio("102081006", var_26_23)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_102081", "102081006", "story_v_out_102081.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_102081", "102081006", "story_v_out_102081.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_24 = math.max(var_26_15, arg_23_1.talkMaxDuration)

			if var_26_14 <= arg_23_1.time_ and arg_23_1.time_ < var_26_14 + var_26_24 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_14) / var_26_24

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_14 + var_26_24 and arg_23_1.time_ < var_26_14 + var_26_24 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play102081007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 102081007
		arg_27_1.duration_ = 3.7

		local var_27_0 = {
			ja = 3.7,
			ko = 1.999999999999,
			zh = 2.333,
			en = 3.3
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play102081008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1084ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.1

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_30_4 = arg_27_1.actors_["1019ui_story"]
			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1019ui_story == nil then
				arg_27_1.var_.characterEffect1019ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.1

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_6 and not isNil(var_30_4) then
				local var_30_7 = (arg_27_1.time_ - var_30_5) / var_30_6

				if arg_27_1.var_.characterEffect1019ui_story and not isNil(var_30_4) then
					local var_30_8 = Mathf.Lerp(0, 0.5, var_30_7)

					arg_27_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1019ui_story.fillRatio = var_30_8
				end
			end

			if arg_27_1.time_ >= var_30_5 + var_30_6 and arg_27_1.time_ < var_30_5 + var_30_6 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1019ui_story then
				local var_30_9 = 0.5

				arg_27_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1019ui_story.fillRatio = var_30_9
			end

			local var_30_10 = arg_27_1.actors_["1084ui_story"].transform
			local var_30_11 = 0

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_10.localPosition
			end

			local var_30_12 = 0.001

			if var_30_11 <= arg_27_1.time_ and arg_27_1.time_ < var_30_11 + var_30_12 then
				local var_30_13 = (arg_27_1.time_ - var_30_11) / var_30_12
				local var_30_14 = Vector3.New(0.7, -0.97, -6)

				var_30_10.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, var_30_14, var_30_13)

				local var_30_15 = manager.ui.mainCamera.transform.position - var_30_10.position

				var_30_10.forward = Vector3.New(var_30_15.x, var_30_15.y, var_30_15.z)

				local var_30_16 = var_30_10.localEulerAngles

				var_30_16.z = 0
				var_30_16.x = 0
				var_30_10.localEulerAngles = var_30_16
			end

			if arg_27_1.time_ >= var_30_11 + var_30_12 and arg_27_1.time_ < var_30_11 + var_30_12 + arg_30_0 then
				var_30_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_30_17 = manager.ui.mainCamera.transform.position - var_30_10.position

				var_30_10.forward = Vector3.New(var_30_17.x, var_30_17.y, var_30_17.z)

				local var_30_18 = var_30_10.localEulerAngles

				var_30_18.z = 0
				var_30_18.x = 0
				var_30_10.localEulerAngles = var_30_18
			end

			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_30_20 = 0

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_21 = 0
			local var_30_22 = 0.175

			if var_30_21 < arg_27_1.time_ and arg_27_1.time_ <= var_30_21 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_23 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_24 = arg_27_1:GetWordFromCfg(102081007)
				local var_30_25 = arg_27_1:FormatText(var_30_24.content)

				arg_27_1.text_.text = var_30_25

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_26 = 7
				local var_30_27 = utf8.len(var_30_25)
				local var_30_28 = var_30_26 <= 0 and var_30_22 or var_30_22 * (var_30_27 / var_30_26)

				if var_30_28 > 0 and var_30_22 < var_30_28 then
					arg_27_1.talkMaxDuration = var_30_28

					if var_30_28 + var_30_21 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_21
					end
				end

				arg_27_1.text_.text = var_30_25
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081007", "story_v_out_102081.awb") ~= 0 then
					local var_30_29 = manager.audio:GetVoiceLength("story_v_out_102081", "102081007", "story_v_out_102081.awb") / 1000

					if var_30_29 + var_30_21 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_29 + var_30_21
					end

					if var_30_24.prefab_name ~= "" and arg_27_1.actors_[var_30_24.prefab_name] ~= nil then
						local var_30_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_24.prefab_name].transform, "story_v_out_102081", "102081007", "story_v_out_102081.awb")

						arg_27_1:RecordAudio("102081007", var_30_30)
						arg_27_1:RecordAudio("102081007", var_30_30)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_102081", "102081007", "story_v_out_102081.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_102081", "102081007", "story_v_out_102081.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_31 = math.max(var_30_22, arg_27_1.talkMaxDuration)

			if var_30_21 <= arg_27_1.time_ and arg_27_1.time_ < var_30_21 + var_30_31 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_21) / var_30_31

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_21 + var_30_31 and arg_27_1.time_ < var_30_21 + var_30_31 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play102081008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 102081008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play102081009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1084ui_story"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.1

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_0) then
					local var_34_4 = Mathf.Lerp(0, 0.5, var_34_3)

					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_4
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.characterEffect1084ui_story then
				local var_34_5 = 0.5

				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = var_34_5
			end

			local var_34_6 = 0
			local var_34_7 = 0.975

			if var_34_6 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:GetWordFromCfg(102081008)
				local var_34_9 = arg_31_1:FormatText(var_34_8.content)

				arg_31_1.text_.text = var_34_9

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 39
				local var_34_11 = utf8.len(var_34_9)
				local var_34_12 = var_34_10 <= 0 and var_34_7 or var_34_7 * (var_34_11 / var_34_10)

				if var_34_12 > 0 and var_34_7 < var_34_12 then
					arg_31_1.talkMaxDuration = var_34_12

					if var_34_12 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_12 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_9
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_13 and arg_31_1.time_ < var_34_6 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play102081009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 102081009
		arg_35_1.duration_ = 2

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play102081010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 1

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				local var_38_2 = "play"
				local var_38_3 = "music"

				arg_35_1:AudioAction(var_38_2, var_38_3, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_38_4 = ""
				local var_38_5 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if var_38_5 ~= "" then
					if arg_35_1.bgmTxt_.text ~= var_38_5 and arg_35_1.bgmTxt_.text ~= "" then
						if arg_35_1.bgmTxt2_.text ~= "" then
							arg_35_1.bgmTxt_.text = arg_35_1.bgmTxt2_.text
						end

						arg_35_1.bgmTxt2_.text = var_38_5

						arg_35_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_35_1.bgmTxt_.text = var_38_5
						arg_35_1.bgmTxt2_.text = var_38_5
					end

					if arg_35_1.bgmTimer then
						arg_35_1.bgmTimer:Stop()

						arg_35_1.bgmTimer = nil
					end

					if arg_35_1.settingData.show_music_name == 1 then
						arg_35_1.musicController:SetSelectedState("show")
						arg_35_1.musicAnimator_:Play("open", 0, 0)

						if arg_35_1.settingData.music_time ~= 0 then
							arg_35_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_35_1.settingData.music_time), function()
								if arg_35_1 == nil or isNil(arg_35_1.bgmTxt_) then
									return
								end

								arg_35_1.musicController:SetSelectedState("hide")
								arg_35_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_38_6 = "10002ui_story"

			if arg_35_1.actors_[var_38_6] == nil then
				local var_38_7 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_38_7) then
					local var_38_8 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_35_1.stage_.transform)

					var_38_8.name = var_38_6
					var_38_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_35_1.actors_[var_38_6] = var_38_8

					local var_38_9 = var_38_8:GetComponentInChildren(typeof(CharacterEffect))

					var_38_9.enabled = true

					local var_38_10 = GameObjectTools.GetOrAddComponent(var_38_8, typeof(DynamicBoneHelper))

					if var_38_10 then
						var_38_10:EnableDynamicBone(false)
					end

					arg_35_1:ShowWeapon(var_38_9.transform, false)

					arg_35_1.var_[var_38_6 .. "Animator"] = var_38_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_35_1.var_[var_38_6 .. "Animator"].applyRootMotion = true
					arg_35_1.var_[var_38_6 .. "LipSync"] = var_38_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_38_11 = arg_35_1.actors_["10002ui_story"]
			local var_38_12 = 0

			if var_38_12 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 and not isNil(var_38_11) and arg_35_1.var_.characterEffect10002ui_story == nil then
				arg_35_1.var_.characterEffect10002ui_story = var_38_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_13 = 0.1

			if var_38_12 <= arg_35_1.time_ and arg_35_1.time_ < var_38_12 + var_38_13 and not isNil(var_38_11) then
				local var_38_14 = (arg_35_1.time_ - var_38_12) / var_38_13

				if arg_35_1.var_.characterEffect10002ui_story and not isNil(var_38_11) then
					arg_35_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_12 + var_38_13 and arg_35_1.time_ < var_38_12 + var_38_13 + arg_38_0 and not isNil(var_38_11) and arg_35_1.var_.characterEffect10002ui_story then
				arg_35_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_38_15 = arg_35_1.actors_["1084ui_story"].transform
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = var_38_15.localPosition
			end

			local var_38_17 = 0.001

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_17 then
				local var_38_18 = (arg_35_1.time_ - var_38_16) / var_38_17
				local var_38_19 = Vector3.New(0, 100, 0)

				var_38_15.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, var_38_19, var_38_18)

				local var_38_20 = manager.ui.mainCamera.transform.position - var_38_15.position

				var_38_15.forward = Vector3.New(var_38_20.x, var_38_20.y, var_38_20.z)

				local var_38_21 = var_38_15.localEulerAngles

				var_38_21.z = 0
				var_38_21.x = 0
				var_38_15.localEulerAngles = var_38_21
			end

			if arg_35_1.time_ >= var_38_16 + var_38_17 and arg_35_1.time_ < var_38_16 + var_38_17 + arg_38_0 then
				var_38_15.localPosition = Vector3.New(0, 100, 0)

				local var_38_22 = manager.ui.mainCamera.transform.position - var_38_15.position

				var_38_15.forward = Vector3.New(var_38_22.x, var_38_22.y, var_38_22.z)

				local var_38_23 = var_38_15.localEulerAngles

				var_38_23.z = 0
				var_38_23.x = 0
				var_38_15.localEulerAngles = var_38_23
			end

			local var_38_24 = arg_35_1.actors_["1019ui_story"].transform
			local var_38_25 = 0

			if var_38_25 < arg_35_1.time_ and arg_35_1.time_ <= var_38_25 + arg_38_0 then
				arg_35_1.var_.moveOldPos1019ui_story = var_38_24.localPosition
			end

			local var_38_26 = 0.001

			if var_38_25 <= arg_35_1.time_ and arg_35_1.time_ < var_38_25 + var_38_26 then
				local var_38_27 = (arg_35_1.time_ - var_38_25) / var_38_26
				local var_38_28 = Vector3.New(0, 100, 0)

				var_38_24.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1019ui_story, var_38_28, var_38_27)

				local var_38_29 = manager.ui.mainCamera.transform.position - var_38_24.position

				var_38_24.forward = Vector3.New(var_38_29.x, var_38_29.y, var_38_29.z)

				local var_38_30 = var_38_24.localEulerAngles

				var_38_30.z = 0
				var_38_30.x = 0
				var_38_24.localEulerAngles = var_38_30
			end

			if arg_35_1.time_ >= var_38_25 + var_38_26 and arg_35_1.time_ < var_38_25 + var_38_26 + arg_38_0 then
				var_38_24.localPosition = Vector3.New(0, 100, 0)

				local var_38_31 = manager.ui.mainCamera.transform.position - var_38_24.position

				var_38_24.forward = Vector3.New(var_38_31.x, var_38_31.y, var_38_31.z)

				local var_38_32 = var_38_24.localEulerAngles

				var_38_32.z = 0
				var_38_32.x = 0
				var_38_24.localEulerAngles = var_38_32
			end

			local var_38_33 = arg_35_1.actors_["10002ui_story"].transform
			local var_38_34 = 0

			if var_38_34 < arg_35_1.time_ and arg_35_1.time_ <= var_38_34 + arg_38_0 then
				arg_35_1.var_.moveOldPos10002ui_story = var_38_33.localPosition
			end

			local var_38_35 = 0.001

			if var_38_34 <= arg_35_1.time_ and arg_35_1.time_ < var_38_34 + var_38_35 then
				local var_38_36 = (arg_35_1.time_ - var_38_34) / var_38_35
				local var_38_37 = Vector3.New(0, -1.2, -5.8)

				var_38_33.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10002ui_story, var_38_37, var_38_36)

				local var_38_38 = manager.ui.mainCamera.transform.position - var_38_33.position

				var_38_33.forward = Vector3.New(var_38_38.x, var_38_38.y, var_38_38.z)

				local var_38_39 = var_38_33.localEulerAngles

				var_38_39.z = 0
				var_38_39.x = 0
				var_38_33.localEulerAngles = var_38_39
			end

			if arg_35_1.time_ >= var_38_34 + var_38_35 and arg_35_1.time_ < var_38_34 + var_38_35 + arg_38_0 then
				var_38_33.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_38_40 = manager.ui.mainCamera.transform.position - var_38_33.position

				var_38_33.forward = Vector3.New(var_38_40.x, var_38_40.y, var_38_40.z)

				local var_38_41 = var_38_33.localEulerAngles

				var_38_41.z = 0
				var_38_41.x = 0
				var_38_33.localEulerAngles = var_38_41
			end

			local var_38_42 = 0

			if var_38_42 < arg_35_1.time_ and arg_35_1.time_ <= var_38_42 + arg_38_0 then
				arg_35_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_38_43 = 0

			if var_38_43 < arg_35_1.time_ and arg_35_1.time_ <= var_38_43 + arg_38_0 then
				arg_35_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_38_44 = 0
			local var_38_45 = 0.05

			if var_38_44 < arg_35_1.time_ and arg_35_1.time_ <= var_38_44 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_46 = arg_35_1:FormatText(StoryNameCfg[39].name)

				arg_35_1.leftNameTxt_.text = var_38_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_47 = arg_35_1:GetWordFromCfg(102081009)
				local var_38_48 = arg_35_1:FormatText(var_38_47.content)

				arg_35_1.text_.text = var_38_48

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_49 = 2
				local var_38_50 = utf8.len(var_38_48)
				local var_38_51 = var_38_49 <= 0 and var_38_45 or var_38_45 * (var_38_50 / var_38_49)

				if var_38_51 > 0 and var_38_45 < var_38_51 then
					arg_35_1.talkMaxDuration = var_38_51

					if var_38_51 + var_38_44 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_51 + var_38_44
					end
				end

				arg_35_1.text_.text = var_38_48
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081009", "story_v_out_102081.awb") ~= 0 then
					local var_38_52 = manager.audio:GetVoiceLength("story_v_out_102081", "102081009", "story_v_out_102081.awb") / 1000

					if var_38_52 + var_38_44 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_52 + var_38_44
					end

					if var_38_47.prefab_name ~= "" and arg_35_1.actors_[var_38_47.prefab_name] ~= nil then
						local var_38_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_47.prefab_name].transform, "story_v_out_102081", "102081009", "story_v_out_102081.awb")

						arg_35_1:RecordAudio("102081009", var_38_53)
						arg_35_1:RecordAudio("102081009", var_38_53)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_102081", "102081009", "story_v_out_102081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_102081", "102081009", "story_v_out_102081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_54 = math.max(var_38_45, arg_35_1.talkMaxDuration)

			if var_38_44 <= arg_35_1.time_ and arg_35_1.time_ < var_38_44 + var_38_54 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_44) / var_38_54

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_44 + var_38_54 and arg_35_1.time_ < var_38_44 + var_38_54 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play102081010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102081010
		arg_40_1.duration_ = 3.63

		local var_40_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play102081011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10002ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10002ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_9
			end

			local var_43_10 = arg_40_1.actors_["10002ui_story"].transform
			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_10.localPosition
			end

			local var_43_12 = 0.001

			if var_43_11 <= arg_40_1.time_ and arg_40_1.time_ < var_43_11 + var_43_12 then
				local var_43_13 = (arg_40_1.time_ - var_43_11) / var_43_12
				local var_43_14 = Vector3.New(0, 100, 0)

				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, var_43_14, var_43_13)

				local var_43_15 = manager.ui.mainCamera.transform.position - var_43_10.position

				var_43_10.forward = Vector3.New(var_43_15.x, var_43_15.y, var_43_15.z)

				local var_43_16 = var_43_10.localEulerAngles

				var_43_16.z = 0
				var_43_16.x = 0
				var_43_10.localEulerAngles = var_43_16
			end

			if arg_40_1.time_ >= var_43_11 + var_43_12 and arg_40_1.time_ < var_43_11 + var_43_12 + arg_43_0 then
				var_43_10.localPosition = Vector3.New(0, 100, 0)

				local var_43_17 = manager.ui.mainCamera.transform.position - var_43_10.position

				var_43_10.forward = Vector3.New(var_43_17.x, var_43_17.y, var_43_17.z)

				local var_43_18 = var_43_10.localEulerAngles

				var_43_18.z = 0
				var_43_18.x = 0
				var_43_10.localEulerAngles = var_43_18
			end

			local var_43_19 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_19.localPosition

				local var_43_21 = "1084ui_story"

				arg_40_1:ShowWeapon(arg_40_1.var_[var_43_21 .. "Animator"].transform, true)
			end

			local var_43_22 = 0.001

			if var_43_20 <= arg_40_1.time_ and arg_40_1.time_ < var_43_20 + var_43_22 then
				local var_43_23 = (arg_40_1.time_ - var_43_20) / var_43_22
				local var_43_24 = Vector3.New(0, -0.97, -6)

				var_43_19.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_24, var_43_23)

				local var_43_25 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_25.x, var_43_25.y, var_43_25.z)

				local var_43_26 = var_43_19.localEulerAngles

				var_43_26.z = 0
				var_43_26.x = 0
				var_43_19.localEulerAngles = var_43_26
			end

			if arg_40_1.time_ >= var_43_20 + var_43_22 and arg_40_1.time_ < var_43_20 + var_43_22 + arg_43_0 then
				var_43_19.localPosition = Vector3.New(0, -0.97, -6)

				local var_43_27 = manager.ui.mainCamera.transform.position - var_43_19.position

				var_43_19.forward = Vector3.New(var_43_27.x, var_43_27.y, var_43_27.z)

				local var_43_28 = var_43_19.localEulerAngles

				var_43_28.z = 0
				var_43_28.x = 0
				var_43_19.localEulerAngles = var_43_28
			end

			local var_43_29 = 0

			if var_43_29 < arg_40_1.time_ and arg_40_1.time_ <= var_43_29 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_43_30 = 0

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_43_31 = 0
			local var_43_32 = 0.175

			if var_43_31 < arg_40_1.time_ and arg_40_1.time_ <= var_43_31 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_33 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_34 = arg_40_1:GetWordFromCfg(102081010)
				local var_43_35 = arg_40_1:FormatText(var_43_34.content)

				arg_40_1.text_.text = var_43_35

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_36 = 7
				local var_43_37 = utf8.len(var_43_35)
				local var_43_38 = var_43_36 <= 0 and var_43_32 or var_43_32 * (var_43_37 / var_43_36)

				if var_43_38 > 0 and var_43_32 < var_43_38 then
					arg_40_1.talkMaxDuration = var_43_38

					if var_43_38 + var_43_31 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_38 + var_43_31
					end
				end

				arg_40_1.text_.text = var_43_35
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081010", "story_v_out_102081.awb") ~= 0 then
					local var_43_39 = manager.audio:GetVoiceLength("story_v_out_102081", "102081010", "story_v_out_102081.awb") / 1000

					if var_43_39 + var_43_31 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_39 + var_43_31
					end

					if var_43_34.prefab_name ~= "" and arg_40_1.actors_[var_43_34.prefab_name] ~= nil then
						local var_43_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_34.prefab_name].transform, "story_v_out_102081", "102081010", "story_v_out_102081.awb")

						arg_40_1:RecordAudio("102081010", var_43_40)
						arg_40_1:RecordAudio("102081010", var_43_40)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102081", "102081010", "story_v_out_102081.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102081", "102081010", "story_v_out_102081.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_41 = math.max(var_43_32, arg_40_1.talkMaxDuration)

			if var_43_31 <= arg_40_1.time_ and arg_40_1.time_ < var_43_31 + var_43_41 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_31) / var_43_41

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_31 + var_43_41 and arg_40_1.time_ < var_43_31 + var_43_41 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play102081011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102081011
		arg_44_1.duration_ = 6.7

		local var_44_0 = {
			ja = 6.7,
			ko = 3.9,
			zh = 3.833,
			en = 5.7
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play102081012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1019ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1084ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_9
			end

			local var_47_10 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_10.localPosition
			end

			local var_47_12 = 0.001

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_12 then
				local var_47_13 = (arg_44_1.time_ - var_47_11) / var_47_12
				local var_47_14 = Vector3.New(0, -0.97, -6)

				var_47_10.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_14, var_47_13)

				local var_47_15 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_15.x, var_47_15.y, var_47_15.z)

				local var_47_16 = var_47_10.localEulerAngles

				var_47_16.z = 0
				var_47_16.x = 0
				var_47_10.localEulerAngles = var_47_16
			end

			if arg_44_1.time_ >= var_47_11 + var_47_12 and arg_44_1.time_ < var_47_11 + var_47_12 + arg_47_0 then
				var_47_10.localPosition = Vector3.New(0, -0.97, -6)

				local var_47_17 = manager.ui.mainCamera.transform.position - var_47_10.position

				var_47_10.forward = Vector3.New(var_47_17.x, var_47_17.y, var_47_17.z)

				local var_47_18 = var_47_10.localEulerAngles

				var_47_18.z = 0
				var_47_18.x = 0
				var_47_10.localEulerAngles = var_47_18
			end

			local var_47_19 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_20 = 0.033

			if var_47_20 < arg_44_1.time_ and arg_44_1.time_ <= var_47_20 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_19.localPosition
			end

			local var_47_21 = 0.5

			if var_47_20 <= arg_44_1.time_ and arg_44_1.time_ < var_47_20 + var_47_21 then
				local var_47_22 = (arg_44_1.time_ - var_47_20) / var_47_21
				local var_47_23 = Vector3.New(0.7, -0.97, -6)

				var_47_19.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_23, var_47_22)

				local var_47_24 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_24.x, var_47_24.y, var_47_24.z)

				local var_47_25 = var_47_19.localEulerAngles

				var_47_25.z = 0
				var_47_25.x = 0
				var_47_19.localEulerAngles = var_47_25
			end

			if arg_44_1.time_ >= var_47_20 + var_47_21 and arg_44_1.time_ < var_47_20 + var_47_21 + arg_47_0 then
				var_47_19.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_47_26 = manager.ui.mainCamera.transform.position - var_47_19.position

				var_47_19.forward = Vector3.New(var_47_26.x, var_47_26.y, var_47_26.z)

				local var_47_27 = var_47_19.localEulerAngles

				var_47_27.z = 0
				var_47_27.x = 0
				var_47_19.localEulerAngles = var_47_27
			end

			local var_47_28 = 0

			if var_47_28 < arg_44_1.time_ and arg_44_1.time_ <= var_47_28 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_47_29 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_30 = 0

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_29.localPosition
			end

			local var_47_31 = 0.001

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_31 then
				local var_47_32 = (arg_44_1.time_ - var_47_30) / var_47_31
				local var_47_33 = Vector3.New(-0.7, -1.08, -5.9)

				var_47_29.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_33, var_47_32)

				local var_47_34 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_34.x, var_47_34.y, var_47_34.z)

				local var_47_35 = var_47_29.localEulerAngles

				var_47_35.z = 0
				var_47_35.x = 0
				var_47_29.localEulerAngles = var_47_35
			end

			if arg_44_1.time_ >= var_47_30 + var_47_31 and arg_44_1.time_ < var_47_30 + var_47_31 + arg_47_0 then
				var_47_29.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_47_36 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_36.x, var_47_36.y, var_47_36.z)

				local var_47_37 = var_47_29.localEulerAngles

				var_47_37.z = 0
				var_47_37.x = 0
				var_47_29.localEulerAngles = var_47_37
			end

			local var_47_38 = 0

			if var_47_38 < arg_44_1.time_ and arg_44_1.time_ <= var_47_38 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_39 = 0
			local var_47_40 = 0.5

			if var_47_39 < arg_44_1.time_ and arg_44_1.time_ <= var_47_39 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_41 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_42 = arg_44_1:GetWordFromCfg(102081011)
				local var_47_43 = arg_44_1:FormatText(var_47_42.content)

				arg_44_1.text_.text = var_47_43

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_44 = 20
				local var_47_45 = utf8.len(var_47_43)
				local var_47_46 = var_47_44 <= 0 and var_47_40 or var_47_40 * (var_47_45 / var_47_44)

				if var_47_46 > 0 and var_47_40 < var_47_46 then
					arg_44_1.talkMaxDuration = var_47_46

					if var_47_46 + var_47_39 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_46 + var_47_39
					end
				end

				arg_44_1.text_.text = var_47_43
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081011", "story_v_out_102081.awb") ~= 0 then
					local var_47_47 = manager.audio:GetVoiceLength("story_v_out_102081", "102081011", "story_v_out_102081.awb") / 1000

					if var_47_47 + var_47_39 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_47 + var_47_39
					end

					if var_47_42.prefab_name ~= "" and arg_44_1.actors_[var_47_42.prefab_name] ~= nil then
						local var_47_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_42.prefab_name].transform, "story_v_out_102081", "102081011", "story_v_out_102081.awb")

						arg_44_1:RecordAudio("102081011", var_47_48)
						arg_44_1:RecordAudio("102081011", var_47_48)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102081", "102081011", "story_v_out_102081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102081", "102081011", "story_v_out_102081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_49 = math.max(var_47_40, arg_44_1.talkMaxDuration)

			if var_47_39 <= arg_44_1.time_ and arg_44_1.time_ < var_47_39 + var_47_49 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_39) / var_47_49

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_39 + var_47_49 and arg_44_1.time_ < var_47_39 + var_47_49 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play102081012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102081012
		arg_48_1.duration_ = 4.07

		local var_48_0 = {
			ja = 2.3,
			ko = 3.9,
			zh = 3.633,
			en = 4.066
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play102081013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10002ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10002ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_51_20 = arg_48_1.actors_["10002ui_story"].transform
			local var_51_21 = 0

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.var_.moveOldPos10002ui_story = var_51_20.localPosition
			end

			local var_51_22 = 0.001

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22
				local var_51_24 = Vector3.New(0.7, -1.2, -5.8)

				var_51_20.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10002ui_story, var_51_24, var_51_23)

				local var_51_25 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_25.x, var_51_25.y, var_51_25.z)

				local var_51_26 = var_51_20.localEulerAngles

				var_51_26.z = 0
				var_51_26.x = 0
				var_51_20.localEulerAngles = var_51_26
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				var_51_20.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_51_27 = manager.ui.mainCamera.transform.position - var_51_20.position

				var_51_20.forward = Vector3.New(var_51_27.x, var_51_27.y, var_51_27.z)

				local var_51_28 = var_51_20.localEulerAngles

				var_51_28.z = 0
				var_51_28.x = 0
				var_51_20.localEulerAngles = var_51_28
			end

			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_51_30 = 0

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_31 = 0
			local var_51_32 = 0.325

			if var_51_31 < arg_48_1.time_ and arg_48_1.time_ <= var_51_31 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_33 = arg_48_1:FormatText(StoryNameCfg[39].name)

				arg_48_1.leftNameTxt_.text = var_51_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_34 = arg_48_1:GetWordFromCfg(102081012)
				local var_51_35 = arg_48_1:FormatText(var_51_34.content)

				arg_48_1.text_.text = var_51_35

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_36 = 13
				local var_51_37 = utf8.len(var_51_35)
				local var_51_38 = var_51_36 <= 0 and var_51_32 or var_51_32 * (var_51_37 / var_51_36)

				if var_51_38 > 0 and var_51_32 < var_51_38 then
					arg_48_1.talkMaxDuration = var_51_38

					if var_51_38 + var_51_31 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_31
					end
				end

				arg_48_1.text_.text = var_51_35
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081012", "story_v_out_102081.awb") ~= 0 then
					local var_51_39 = manager.audio:GetVoiceLength("story_v_out_102081", "102081012", "story_v_out_102081.awb") / 1000

					if var_51_39 + var_51_31 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_39 + var_51_31
					end

					if var_51_34.prefab_name ~= "" and arg_48_1.actors_[var_51_34.prefab_name] ~= nil then
						local var_51_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_34.prefab_name].transform, "story_v_out_102081", "102081012", "story_v_out_102081.awb")

						arg_48_1:RecordAudio("102081012", var_51_40)
						arg_48_1:RecordAudio("102081012", var_51_40)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102081", "102081012", "story_v_out_102081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102081", "102081012", "story_v_out_102081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_41 = math.max(var_51_32, arg_48_1.talkMaxDuration)

			if var_51_31 <= arg_48_1.time_ and arg_48_1.time_ < var_51_31 + var_51_41 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_31) / var_51_41

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_31 + var_51_41 and arg_48_1.time_ < var_51_31 + var_51_41 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play102081013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102081013
		arg_52_1.duration_ = 2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play102081014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1019ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["10002ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect10002ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = var_55_9
			end

			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_55_11 = 0
			local var_55_12 = 0.05

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_13 = arg_52_1:FormatText(StoryNameCfg[13].name)

				arg_52_1.leftNameTxt_.text = var_55_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(102081013)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_16 = 2
				local var_55_17 = utf8.len(var_55_15)
				local var_55_18 = var_55_16 <= 0 and var_55_12 or var_55_12 * (var_55_17 / var_55_16)

				if var_55_18 > 0 and var_55_12 < var_55_18 then
					arg_52_1.talkMaxDuration = var_55_18

					if var_55_18 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_11
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081013", "story_v_out_102081.awb") ~= 0 then
					local var_55_19 = manager.audio:GetVoiceLength("story_v_out_102081", "102081013", "story_v_out_102081.awb") / 1000

					if var_55_19 + var_55_11 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_19 + var_55_11
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_102081", "102081013", "story_v_out_102081.awb")

						arg_52_1:RecordAudio("102081013", var_55_20)
						arg_52_1:RecordAudio("102081013", var_55_20)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102081", "102081013", "story_v_out_102081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102081", "102081013", "story_v_out_102081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_21 = math.max(var_55_12, arg_52_1.talkMaxDuration)

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_21 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_11) / var_55_21

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_11 + var_55_21 and arg_52_1.time_ < var_55_11 + var_55_21 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play102081014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102081014
		arg_56_1.duration_ = 7.1

		local var_56_0 = {
			ja = 7.1,
			ko = 6.533,
			zh = 5.333,
			en = 5.933
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play102081015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10002ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10002ui_story == nil then
				arg_56_1.var_.characterEffect10002ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10002ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10002ui_story then
				arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1019ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_12 = 0
			local var_59_13 = 0.725

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[39].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_15 = arg_56_1:GetWordFromCfg(102081014)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 29
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_13 or var_59_13 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_13 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19

					if var_59_19 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081014", "story_v_out_102081.awb") ~= 0 then
					local var_59_20 = manager.audio:GetVoiceLength("story_v_out_102081", "102081014", "story_v_out_102081.awb") / 1000

					if var_59_20 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_12
					end

					if var_59_15.prefab_name ~= "" and arg_56_1.actors_[var_59_15.prefab_name] ~= nil then
						local var_59_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_15.prefab_name].transform, "story_v_out_102081", "102081014", "story_v_out_102081.awb")

						arg_56_1:RecordAudio("102081014", var_59_21)
						arg_56_1:RecordAudio("102081014", var_59_21)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102081", "102081014", "story_v_out_102081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102081", "102081014", "story_v_out_102081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_22 and arg_56_1.time_ < var_59_12 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play102081015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102081015
		arg_60_1.duration_ = 6.91

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play102081016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1019ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["10002ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect10002ui_story == nil then
				arg_60_1.var_.characterEffect10002ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect10002ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10002ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect10002ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10002ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_12 = 0
			local var_63_13 = 0.5

			if var_63_12 < arg_60_1.time_ and arg_60_1.time_ <= var_63_12 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_14 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_15 = arg_60_1:GetWordFromCfg(102081015)
				local var_63_16 = arg_60_1:FormatText(var_63_15.content)

				arg_60_1.text_.text = var_63_16

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_17 = 20
				local var_63_18 = utf8.len(var_63_16)
				local var_63_19 = var_63_17 <= 0 and var_63_13 or var_63_13 * (var_63_18 / var_63_17)

				if var_63_19 > 0 and var_63_13 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19

					if var_63_19 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_12
					end
				end

				arg_60_1.text_.text = var_63_16
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081015", "story_v_out_102081.awb") ~= 0 then
					local var_63_20 = manager.audio:GetVoiceLength("story_v_out_102081", "102081015", "story_v_out_102081.awb") / 1000

					if var_63_20 + var_63_12 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_20 + var_63_12
					end

					if var_63_15.prefab_name ~= "" and arg_60_1.actors_[var_63_15.prefab_name] ~= nil then
						local var_63_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_15.prefab_name].transform, "story_v_out_102081", "102081015", "story_v_out_102081.awb")

						arg_60_1:RecordAudio("102081015", var_63_21)
						arg_60_1:RecordAudio("102081015", var_63_21)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102081", "102081015", "story_v_out_102081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102081", "102081015", "story_v_out_102081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = math.max(var_63_13, arg_60_1.talkMaxDuration)

			if var_63_12 <= arg_60_1.time_ and arg_60_1.time_ < var_63_12 + var_63_22 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_12) / var_63_22

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_12 + var_63_22 and arg_60_1.time_ < var_63_12 + var_63_22 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play102081016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102081016
		arg_64_1.duration_ = 11.97

		local var_64_0 = {
			ja = 9.966,
			ko = 8.966,
			zh = 10.433,
			en = 11.966
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play102081017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10002ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story == nil then
				arg_64_1.var_.characterEffect10002ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10002ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10002ui_story then
				arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1019ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_67_11 = 0
			local var_67_12 = 1.075

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_13 = arg_64_1:FormatText(StoryNameCfg[39].name)

				arg_64_1.leftNameTxt_.text = var_67_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(102081016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 43
				local var_67_17 = utf8.len(var_67_15)
				local var_67_18 = var_67_16 <= 0 and var_67_12 or var_67_12 * (var_67_17 / var_67_16)

				if var_67_18 > 0 and var_67_12 < var_67_18 then
					arg_64_1.talkMaxDuration = var_67_18

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081016", "story_v_out_102081.awb") ~= 0 then
					local var_67_19 = manager.audio:GetVoiceLength("story_v_out_102081", "102081016", "story_v_out_102081.awb") / 1000

					if var_67_19 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_102081", "102081016", "story_v_out_102081.awb")

						arg_64_1:RecordAudio("102081016", var_67_20)
						arg_64_1:RecordAudio("102081016", var_67_20)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102081", "102081016", "story_v_out_102081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102081", "102081016", "story_v_out_102081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_21 and arg_64_1.time_ < var_67_11 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play102081017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102081017
		arg_68_1.duration_ = 11.3

		local var_68_0 = {
			ja = 9.433,
			ko = 7.333,
			zh = 6.366,
			en = 11.3
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play102081018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1019ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1019ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1019ui_story then
				arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["10002ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10002ui_story == nil then
				arg_68_1.var_.characterEffect10002ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect10002ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10002ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect10002ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10002ui_story.fillRatio = var_71_9
			end

			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_11 = 0
			local var_71_12 = 0.725

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_13 = arg_68_1:FormatText(StoryNameCfg[13].name)

				arg_68_1.leftNameTxt_.text = var_71_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_14 = arg_68_1:GetWordFromCfg(102081017)
				local var_71_15 = arg_68_1:FormatText(var_71_14.content)

				arg_68_1.text_.text = var_71_15

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_16 = 29
				local var_71_17 = utf8.len(var_71_15)
				local var_71_18 = var_71_16 <= 0 and var_71_12 or var_71_12 * (var_71_17 / var_71_16)

				if var_71_18 > 0 and var_71_12 < var_71_18 then
					arg_68_1.talkMaxDuration = var_71_18

					if var_71_18 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_18 + var_71_11
					end
				end

				arg_68_1.text_.text = var_71_15
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081017", "story_v_out_102081.awb") ~= 0 then
					local var_71_19 = manager.audio:GetVoiceLength("story_v_out_102081", "102081017", "story_v_out_102081.awb") / 1000

					if var_71_19 + var_71_11 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_19 + var_71_11
					end

					if var_71_14.prefab_name ~= "" and arg_68_1.actors_[var_71_14.prefab_name] ~= nil then
						local var_71_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_14.prefab_name].transform, "story_v_out_102081", "102081017", "story_v_out_102081.awb")

						arg_68_1:RecordAudio("102081017", var_71_20)
						arg_68_1:RecordAudio("102081017", var_71_20)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102081", "102081017", "story_v_out_102081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102081", "102081017", "story_v_out_102081.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_21 = math.max(var_71_12, arg_68_1.talkMaxDuration)

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_21 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_11) / var_71_21

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_11 + var_71_21 and arg_68_1.time_ < var_71_11 + var_71_21 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play102081018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102081018
		arg_72_1.duration_ = 13.2

		local var_72_0 = {
			ja = 13.2,
			ko = 7.266,
			zh = 6.8,
			en = 9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play102081019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_75_2 = 0
			local var_75_3 = 0.9

			if var_75_2 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_4 = arg_72_1:FormatText(StoryNameCfg[13].name)

				arg_72_1.leftNameTxt_.text = var_75_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:GetWordFromCfg(102081018)
				local var_75_6 = arg_72_1:FormatText(var_75_5.content)

				arg_72_1.text_.text = var_75_6

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 36
				local var_75_8 = utf8.len(var_75_6)
				local var_75_9 = var_75_7 <= 0 and var_75_3 or var_75_3 * (var_75_8 / var_75_7)

				if var_75_9 > 0 and var_75_3 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_6
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081018", "story_v_out_102081.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081018", "story_v_out_102081.awb") / 1000

					if var_75_10 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_2
					end

					if var_75_5.prefab_name ~= "" and arg_72_1.actors_[var_75_5.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_5.prefab_name].transform, "story_v_out_102081", "102081018", "story_v_out_102081.awb")

						arg_72_1:RecordAudio("102081018", var_75_11)
						arg_72_1:RecordAudio("102081018", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102081", "102081018", "story_v_out_102081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102081", "102081018", "story_v_out_102081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_12 and arg_72_1.time_ < var_75_2 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play102081019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102081019
		arg_76_1.duration_ = 5.93

		local var_76_0 = {
			ja = 4.766,
			ko = 5.933,
			zh = 4.166,
			en = 4.9
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play102081020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["10002ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect10002ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect10002ui_story then
				arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1019ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1019ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1019ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1019ui_story.fillRatio = var_79_9
			end

			local var_79_10 = 0

			if var_79_10 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_79_11 = 0
			local var_79_12 = 0.375

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_13 = arg_76_1:FormatText(StoryNameCfg[39].name)

				arg_76_1.leftNameTxt_.text = var_79_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_14 = arg_76_1:GetWordFromCfg(102081019)
				local var_79_15 = arg_76_1:FormatText(var_79_14.content)

				arg_76_1.text_.text = var_79_15

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_16 = 15
				local var_79_17 = utf8.len(var_79_15)
				local var_79_18 = var_79_16 <= 0 and var_79_12 or var_79_12 * (var_79_17 / var_79_16)

				if var_79_18 > 0 and var_79_12 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18

					if var_79_18 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_11
					end
				end

				arg_76_1.text_.text = var_79_15
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081019", "story_v_out_102081.awb") ~= 0 then
					local var_79_19 = manager.audio:GetVoiceLength("story_v_out_102081", "102081019", "story_v_out_102081.awb") / 1000

					if var_79_19 + var_79_11 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_11
					end

					if var_79_14.prefab_name ~= "" and arg_76_1.actors_[var_79_14.prefab_name] ~= nil then
						local var_79_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_14.prefab_name].transform, "story_v_out_102081", "102081019", "story_v_out_102081.awb")

						arg_76_1:RecordAudio("102081019", var_79_20)
						arg_76_1:RecordAudio("102081019", var_79_20)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_102081", "102081019", "story_v_out_102081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_102081", "102081019", "story_v_out_102081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = math.max(var_79_12, arg_76_1.talkMaxDuration)

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_21 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_11) / var_79_21

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_11 + var_79_21 and arg_76_1.time_ < var_79_11 + var_79_21 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play102081020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102081020
		arg_80_1.duration_ = 4.77

		local var_80_0 = {
			ja = 4.766,
			ko = 4.2,
			zh = 3.966,
			en = 2.9
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play102081021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1019ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1019ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, 100, 0)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1019ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, 100, 0)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["10002ui_story"].transform
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_9.localPosition
			end

			local var_83_11 = 0.001

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11
				local var_83_13 = Vector3.New(0.7, -1.2, -5.8)

				var_83_9.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, var_83_13, var_83_12)

				local var_83_14 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_14.x, var_83_14.y, var_83_14.z)

				local var_83_15 = var_83_9.localEulerAngles

				var_83_15.z = 0
				var_83_15.x = 0
				var_83_9.localEulerAngles = var_83_15
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 then
				var_83_9.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_83_16 = manager.ui.mainCamera.transform.position - var_83_9.position

				var_83_9.forward = Vector3.New(var_83_16.x, var_83_16.y, var_83_16.z)

				local var_83_17 = var_83_9.localEulerAngles

				var_83_17.z = 0
				var_83_17.x = 0
				var_83_9.localEulerAngles = var_83_17
			end

			local var_83_18 = arg_80_1.actors_["10002ui_story"].transform
			local var_83_19 = 0.033

			if var_83_19 < arg_80_1.time_ and arg_80_1.time_ <= var_83_19 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_18.localPosition
			end

			local var_83_20 = 0.5

			if var_83_19 <= arg_80_1.time_ and arg_80_1.time_ < var_83_19 + var_83_20 then
				local var_83_21 = (arg_80_1.time_ - var_83_19) / var_83_20
				local var_83_22 = Vector3.New(0, -1.2, -5.8)

				var_83_18.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, var_83_22, var_83_21)

				local var_83_23 = manager.ui.mainCamera.transform.position - var_83_18.position

				var_83_18.forward = Vector3.New(var_83_23.x, var_83_23.y, var_83_23.z)

				local var_83_24 = var_83_18.localEulerAngles

				var_83_24.z = 0
				var_83_24.x = 0
				var_83_18.localEulerAngles = var_83_24
			end

			if arg_80_1.time_ >= var_83_19 + var_83_20 and arg_80_1.time_ < var_83_19 + var_83_20 + arg_83_0 then
				var_83_18.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_83_25 = manager.ui.mainCamera.transform.position - var_83_18.position

				var_83_18.forward = Vector3.New(var_83_25.x, var_83_25.y, var_83_25.z)

				local var_83_26 = var_83_18.localEulerAngles

				var_83_26.z = 0
				var_83_26.x = 0
				var_83_18.localEulerAngles = var_83_26
			end

			local var_83_27 = 0

			if var_83_27 < arg_80_1.time_ and arg_80_1.time_ <= var_83_27 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_83_28 = 0
			local var_83_29 = 0.275

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_30 = arg_80_1:FormatText(StoryNameCfg[39].name)

				arg_80_1.leftNameTxt_.text = var_83_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_31 = arg_80_1:GetWordFromCfg(102081020)
				local var_83_32 = arg_80_1:FormatText(var_83_31.content)

				arg_80_1.text_.text = var_83_32

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_33 = 11
				local var_83_34 = utf8.len(var_83_32)
				local var_83_35 = var_83_33 <= 0 and var_83_29 or var_83_29 * (var_83_34 / var_83_33)

				if var_83_35 > 0 and var_83_29 < var_83_35 then
					arg_80_1.talkMaxDuration = var_83_35

					if var_83_35 + var_83_28 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_35 + var_83_28
					end
				end

				arg_80_1.text_.text = var_83_32
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081020", "story_v_out_102081.awb") ~= 0 then
					local var_83_36 = manager.audio:GetVoiceLength("story_v_out_102081", "102081020", "story_v_out_102081.awb") / 1000

					if var_83_36 + var_83_28 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_36 + var_83_28
					end

					if var_83_31.prefab_name ~= "" and arg_80_1.actors_[var_83_31.prefab_name] ~= nil then
						local var_83_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_31.prefab_name].transform, "story_v_out_102081", "102081020", "story_v_out_102081.awb")

						arg_80_1:RecordAudio("102081020", var_83_37)
						arg_80_1:RecordAudio("102081020", var_83_37)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102081", "102081020", "story_v_out_102081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102081", "102081020", "story_v_out_102081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_38 = math.max(var_83_29, arg_80_1.talkMaxDuration)

			if var_83_28 <= arg_80_1.time_ and arg_80_1.time_ < var_83_28 + var_83_38 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_28) / var_83_38

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_28 + var_83_38 and arg_80_1.time_ < var_83_28 + var_83_38 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play102081021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102081021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102081022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10002ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10002ui_story == nil then
				arg_84_1.var_.characterEffect10002ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10002ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10002ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10002ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10002ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.625

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(102081021)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 25
				local var_87_11 = utf8.len(var_87_9)
				local var_87_12 = var_87_10 <= 0 and var_87_7 or var_87_7 * (var_87_11 / var_87_10)

				if var_87_12 > 0 and var_87_7 < var_87_12 then
					arg_84_1.talkMaxDuration = var_87_12

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_13 and arg_84_1.time_ < var_87_6 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play102081022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102081022
		arg_88_1.duration_ = 9.27

		local var_88_0 = {
			ja = 6.833,
			ko = 9.266,
			zh = 8.066,
			en = 8.9
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play102081023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10002ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10002ui_story == nil then
				arg_88_1.var_.characterEffect10002ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10002ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10002ui_story then
				arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_91_5 = 0
			local var_91_6 = 0.775

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_7 = arg_88_1:FormatText(StoryNameCfg[39].name)

				arg_88_1.leftNameTxt_.text = var_91_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_8 = arg_88_1:GetWordFromCfg(102081022)
				local var_91_9 = arg_88_1:FormatText(var_91_8.content)

				arg_88_1.text_.text = var_91_9

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 31
				local var_91_11 = utf8.len(var_91_9)
				local var_91_12 = var_91_10 <= 0 and var_91_6 or var_91_6 * (var_91_11 / var_91_10)

				if var_91_12 > 0 and var_91_6 < var_91_12 then
					arg_88_1.talkMaxDuration = var_91_12

					if var_91_12 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_12 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_9
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081022", "story_v_out_102081.awb") ~= 0 then
					local var_91_13 = manager.audio:GetVoiceLength("story_v_out_102081", "102081022", "story_v_out_102081.awb") / 1000

					if var_91_13 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_5
					end

					if var_91_8.prefab_name ~= "" and arg_88_1.actors_[var_91_8.prefab_name] ~= nil then
						local var_91_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_8.prefab_name].transform, "story_v_out_102081", "102081022", "story_v_out_102081.awb")

						arg_88_1:RecordAudio("102081022", var_91_14)
						arg_88_1:RecordAudio("102081022", var_91_14)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102081", "102081022", "story_v_out_102081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102081", "102081022", "story_v_out_102081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_15 and arg_88_1.time_ < var_91_5 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play102081023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102081023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102081024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10002ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story == nil then
				arg_92_1.var_.characterEffect10002ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10002ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10002ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10002ui_story.fillRatio = var_95_5
			end

			local var_95_6 = arg_92_1.actors_["10002ui_story"].transform
			local var_95_7 = 0

			if var_95_7 < arg_92_1.time_ and arg_92_1.time_ <= var_95_7 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_6.localPosition
			end

			local var_95_8 = 0.001

			if var_95_7 <= arg_92_1.time_ and arg_92_1.time_ < var_95_7 + var_95_8 then
				local var_95_9 = (arg_92_1.time_ - var_95_7) / var_95_8
				local var_95_10 = Vector3.New(0, 100, 0)

				var_95_6.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, var_95_10, var_95_9)

				local var_95_11 = manager.ui.mainCamera.transform.position - var_95_6.position

				var_95_6.forward = Vector3.New(var_95_11.x, var_95_11.y, var_95_11.z)

				local var_95_12 = var_95_6.localEulerAngles

				var_95_12.z = 0
				var_95_12.x = 0
				var_95_6.localEulerAngles = var_95_12
			end

			if arg_92_1.time_ >= var_95_7 + var_95_8 and arg_92_1.time_ < var_95_7 + var_95_8 + arg_95_0 then
				var_95_6.localPosition = Vector3.New(0, 100, 0)

				local var_95_13 = manager.ui.mainCamera.transform.position - var_95_6.position

				var_95_6.forward = Vector3.New(var_95_13.x, var_95_13.y, var_95_13.z)

				local var_95_14 = var_95_6.localEulerAngles

				var_95_14.z = 0
				var_95_14.x = 0
				var_95_6.localEulerAngles = var_95_14
			end

			local var_95_15 = 0
			local var_95_16 = 0.625

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_17 = arg_92_1:GetWordFromCfg(102081023)
				local var_95_18 = arg_92_1:FormatText(var_95_17.content)

				arg_92_1.text_.text = var_95_18

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_19 = 25
				local var_95_20 = utf8.len(var_95_18)
				local var_95_21 = var_95_19 <= 0 and var_95_16 or var_95_16 * (var_95_20 / var_95_19)

				if var_95_21 > 0 and var_95_16 < var_95_21 then
					arg_92_1.talkMaxDuration = var_95_21

					if var_95_21 + var_95_15 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_21 + var_95_15
					end
				end

				arg_92_1.text_.text = var_95_18
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_22 = math.max(var_95_16, arg_92_1.talkMaxDuration)

			if var_95_15 <= arg_92_1.time_ and arg_92_1.time_ < var_95_15 + var_95_22 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_15) / var_95_22

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_15 + var_95_22 and arg_92_1.time_ < var_95_15 + var_95_22 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play102081024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102081024
		arg_96_1.duration_ = 12.57

		local var_96_0 = {
			ja = 11.833,
			ko = 12.566,
			zh = 8.233,
			en = 10.033
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102081025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10002ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10002ui_story == nil then
				arg_96_1.var_.characterEffect10002ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10002ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10002ui_story then
				arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["10002ui_story"].transform
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.var_.moveOldPos10002ui_story = var_99_4.localPosition
			end

			local var_99_6 = 0.001

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6
				local var_99_8 = Vector3.New(0, -1.2, -5.8)

				var_99_4.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10002ui_story, var_99_8, var_99_7)

				local var_99_9 = manager.ui.mainCamera.transform.position - var_99_4.position

				var_99_4.forward = Vector3.New(var_99_9.x, var_99_9.y, var_99_9.z)

				local var_99_10 = var_99_4.localEulerAngles

				var_99_10.z = 0
				var_99_10.x = 0
				var_99_4.localEulerAngles = var_99_10
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 then
				var_99_4.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_99_11 = manager.ui.mainCamera.transform.position - var_99_4.position

				var_99_4.forward = Vector3.New(var_99_11.x, var_99_11.y, var_99_11.z)

				local var_99_12 = var_99_4.localEulerAngles

				var_99_12.z = 0
				var_99_12.x = 0
				var_99_4.localEulerAngles = var_99_12
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_15 = 0
			local var_99_16 = 1

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[39].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(102081024)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 40
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081024", "story_v_out_102081.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_102081", "102081024", "story_v_out_102081.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_102081", "102081024", "story_v_out_102081.awb")

						arg_96_1:RecordAudio("102081024", var_99_24)
						arg_96_1:RecordAudio("102081024", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102081", "102081024", "story_v_out_102081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102081", "102081024", "story_v_out_102081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play102081025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102081025
		arg_100_1.duration_ = 5.73

		local var_100_0 = {
			ja = 4.3,
			ko = 5.733,
			zh = 3.566,
			en = 3.766
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play102081026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1019ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.1

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1019ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["10002ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10002ui_story == nil then
				arg_100_1.var_.characterEffect10002ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.1

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect10002ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10002ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10002ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10002ui_story.fillRatio = var_103_9
			end

			local var_103_10 = arg_100_1.actors_["10002ui_story"].transform
			local var_103_11 = 0

			if var_103_11 < arg_100_1.time_ and arg_100_1.time_ <= var_103_11 + arg_103_0 then
				arg_100_1.var_.moveOldPos10002ui_story = var_103_10.localPosition
			end

			local var_103_12 = 0.001

			if var_103_11 <= arg_100_1.time_ and arg_100_1.time_ < var_103_11 + var_103_12 then
				local var_103_13 = (arg_100_1.time_ - var_103_11) / var_103_12
				local var_103_14 = Vector3.New(0, 100, 0)

				var_103_10.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10002ui_story, var_103_14, var_103_13)

				local var_103_15 = manager.ui.mainCamera.transform.position - var_103_10.position

				var_103_10.forward = Vector3.New(var_103_15.x, var_103_15.y, var_103_15.z)

				local var_103_16 = var_103_10.localEulerAngles

				var_103_16.z = 0
				var_103_16.x = 0
				var_103_10.localEulerAngles = var_103_16
			end

			if arg_100_1.time_ >= var_103_11 + var_103_12 and arg_100_1.time_ < var_103_11 + var_103_12 + arg_103_0 then
				var_103_10.localPosition = Vector3.New(0, 100, 0)

				local var_103_17 = manager.ui.mainCamera.transform.position - var_103_10.position

				var_103_10.forward = Vector3.New(var_103_17.x, var_103_17.y, var_103_17.z)

				local var_103_18 = var_103_10.localEulerAngles

				var_103_18.z = 0
				var_103_18.x = 0
				var_103_10.localEulerAngles = var_103_18
			end

			local var_103_19 = arg_100_1.actors_["1019ui_story"].transform
			local var_103_20 = 0

			if var_103_20 < arg_100_1.time_ and arg_100_1.time_ <= var_103_20 + arg_103_0 then
				arg_100_1.var_.moveOldPos1019ui_story = var_103_19.localPosition
			end

			local var_103_21 = 0.001

			if var_103_20 <= arg_100_1.time_ and arg_100_1.time_ < var_103_20 + var_103_21 then
				local var_103_22 = (arg_100_1.time_ - var_103_20) / var_103_21
				local var_103_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_103_19.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1019ui_story, var_103_23, var_103_22)

				local var_103_24 = manager.ui.mainCamera.transform.position - var_103_19.position

				var_103_19.forward = Vector3.New(var_103_24.x, var_103_24.y, var_103_24.z)

				local var_103_25 = var_103_19.localEulerAngles

				var_103_25.z = 0
				var_103_25.x = 0
				var_103_19.localEulerAngles = var_103_25
			end

			if arg_100_1.time_ >= var_103_20 + var_103_21 and arg_100_1.time_ < var_103_20 + var_103_21 + arg_103_0 then
				var_103_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_103_26 = manager.ui.mainCamera.transform.position - var_103_19.position

				var_103_19.forward = Vector3.New(var_103_26.x, var_103_26.y, var_103_26.z)

				local var_103_27 = var_103_19.localEulerAngles

				var_103_27.z = 0
				var_103_27.x = 0
				var_103_19.localEulerAngles = var_103_27
			end

			local var_103_28 = 0

			if var_103_28 < arg_100_1.time_ and arg_100_1.time_ <= var_103_28 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_103_29 = 0

			if var_103_29 < arg_100_1.time_ and arg_100_1.time_ <= var_103_29 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_30 = 0
			local var_103_31 = 0.425

			if var_103_30 < arg_100_1.time_ and arg_100_1.time_ <= var_103_30 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_32 = arg_100_1:FormatText(StoryNameCfg[13].name)

				arg_100_1.leftNameTxt_.text = var_103_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_33 = arg_100_1:GetWordFromCfg(102081025)
				local var_103_34 = arg_100_1:FormatText(var_103_33.content)

				arg_100_1.text_.text = var_103_34

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_35 = 17
				local var_103_36 = utf8.len(var_103_34)
				local var_103_37 = var_103_35 <= 0 and var_103_31 or var_103_31 * (var_103_36 / var_103_35)

				if var_103_37 > 0 and var_103_31 < var_103_37 then
					arg_100_1.talkMaxDuration = var_103_37

					if var_103_37 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_37 + var_103_30
					end
				end

				arg_100_1.text_.text = var_103_34
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081025", "story_v_out_102081.awb") ~= 0 then
					local var_103_38 = manager.audio:GetVoiceLength("story_v_out_102081", "102081025", "story_v_out_102081.awb") / 1000

					if var_103_38 + var_103_30 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_38 + var_103_30
					end

					if var_103_33.prefab_name ~= "" and arg_100_1.actors_[var_103_33.prefab_name] ~= nil then
						local var_103_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_33.prefab_name].transform, "story_v_out_102081", "102081025", "story_v_out_102081.awb")

						arg_100_1:RecordAudio("102081025", var_103_39)
						arg_100_1:RecordAudio("102081025", var_103_39)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102081", "102081025", "story_v_out_102081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102081", "102081025", "story_v_out_102081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_40 = math.max(var_103_31, arg_100_1.talkMaxDuration)

			if var_103_30 <= arg_100_1.time_ and arg_100_1.time_ < var_103_30 + var_103_40 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_30) / var_103_40

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_30 + var_103_40 and arg_100_1.time_ < var_103_30 + var_103_40 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play102081026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102081026
		arg_104_1.duration_ = 3.2

		local var_104_0 = {
			ja = 1.999999999999,
			ko = 2.266,
			zh = 3.2,
			en = 1.999999999999
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play102081027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10002ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10002ui_story == nil then
				arg_104_1.var_.characterEffect10002ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.1

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10002ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10002ui_story then
				arg_104_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1019ui_story"].transform
			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_4.localPosition
			end

			local var_107_6 = 0.001

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_6 then
				local var_107_7 = (arg_104_1.time_ - var_107_5) / var_107_6
				local var_107_8 = Vector3.New(0, 100, 0)

				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, var_107_8, var_107_7)

				local var_107_9 = manager.ui.mainCamera.transform.position - var_107_4.position

				var_107_4.forward = Vector3.New(var_107_9.x, var_107_9.y, var_107_9.z)

				local var_107_10 = var_107_4.localEulerAngles

				var_107_10.z = 0
				var_107_10.x = 0
				var_107_4.localEulerAngles = var_107_10
			end

			if arg_104_1.time_ >= var_107_5 + var_107_6 and arg_104_1.time_ < var_107_5 + var_107_6 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0, 100, 0)

				local var_107_11 = manager.ui.mainCamera.transform.position - var_107_4.position

				var_107_4.forward = Vector3.New(var_107_11.x, var_107_11.y, var_107_11.z)

				local var_107_12 = var_107_4.localEulerAngles

				var_107_12.z = 0
				var_107_12.x = 0
				var_107_4.localEulerAngles = var_107_12
			end

			local var_107_13 = arg_104_1.actors_["10002ui_story"].transform
			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1.var_.moveOldPos10002ui_story = var_107_13.localPosition
			end

			local var_107_15 = 0.001

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_15 then
				local var_107_16 = (arg_104_1.time_ - var_107_14) / var_107_15
				local var_107_17 = Vector3.New(0, -1.2, -5.8)

				var_107_13.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10002ui_story, var_107_17, var_107_16)

				local var_107_18 = manager.ui.mainCamera.transform.position - var_107_13.position

				var_107_13.forward = Vector3.New(var_107_18.x, var_107_18.y, var_107_18.z)

				local var_107_19 = var_107_13.localEulerAngles

				var_107_19.z = 0
				var_107_19.x = 0
				var_107_13.localEulerAngles = var_107_19
			end

			if arg_104_1.time_ >= var_107_14 + var_107_15 and arg_104_1.time_ < var_107_14 + var_107_15 + arg_107_0 then
				var_107_13.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_107_20 = manager.ui.mainCamera.transform.position - var_107_13.position

				var_107_13.forward = Vector3.New(var_107_20.x, var_107_20.y, var_107_20.z)

				local var_107_21 = var_107_13.localEulerAngles

				var_107_21.z = 0
				var_107_21.x = 0
				var_107_13.localEulerAngles = var_107_21
			end

			local var_107_22 = 0

			if var_107_22 < arg_104_1.time_ and arg_104_1.time_ <= var_107_22 + arg_107_0 then
				arg_104_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_107_23 = 0

			if var_107_23 < arg_104_1.time_ and arg_104_1.time_ <= var_107_23 + arg_107_0 then
				arg_104_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_107_24 = 0
			local var_107_25 = 0.05

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_26 = arg_104_1:FormatText(StoryNameCfg[39].name)

				arg_104_1.leftNameTxt_.text = var_107_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_27 = arg_104_1:GetWordFromCfg(102081026)
				local var_107_28 = arg_104_1:FormatText(var_107_27.content)

				arg_104_1.text_.text = var_107_28

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_29 = 2
				local var_107_30 = utf8.len(var_107_28)
				local var_107_31 = var_107_29 <= 0 and var_107_25 or var_107_25 * (var_107_30 / var_107_29)

				if var_107_31 > 0 and var_107_25 < var_107_31 then
					arg_104_1.talkMaxDuration = var_107_31

					if var_107_31 + var_107_24 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_31 + var_107_24
					end
				end

				arg_104_1.text_.text = var_107_28
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081026", "story_v_out_102081.awb") ~= 0 then
					local var_107_32 = manager.audio:GetVoiceLength("story_v_out_102081", "102081026", "story_v_out_102081.awb") / 1000

					if var_107_32 + var_107_24 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_32 + var_107_24
					end

					if var_107_27.prefab_name ~= "" and arg_104_1.actors_[var_107_27.prefab_name] ~= nil then
						local var_107_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_27.prefab_name].transform, "story_v_out_102081", "102081026", "story_v_out_102081.awb")

						arg_104_1:RecordAudio("102081026", var_107_33)
						arg_104_1:RecordAudio("102081026", var_107_33)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102081", "102081026", "story_v_out_102081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102081", "102081026", "story_v_out_102081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_34 = math.max(var_107_25, arg_104_1.talkMaxDuration)

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_34 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_24) / var_107_34

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_24 + var_107_34 and arg_104_1.time_ < var_107_24 + var_107_34 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play102081027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102081027
		arg_108_1.duration_ = 7.2

		local var_108_0 = {
			ja = 7.2,
			ko = 3.766,
			zh = 4.433,
			en = 4.2
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play102081028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1011ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1011ui_story == nil then
				arg_108_1.var_.characterEffect1011ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.1

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1011ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1011ui_story then
				arg_108_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["10002ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect10002ui_story == nil then
				arg_108_1.var_.characterEffect10002ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect10002ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10002ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect10002ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10002ui_story.fillRatio = var_111_9
			end

			local var_111_10 = arg_108_1.actors_["10002ui_story"].transform
			local var_111_11 = 0

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.var_.moveOldPos10002ui_story = var_111_10.localPosition
			end

			local var_111_12 = 0.001

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_12 then
				local var_111_13 = (arg_108_1.time_ - var_111_11) / var_111_12
				local var_111_14 = Vector3.New(0, 100, 0)

				var_111_10.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10002ui_story, var_111_14, var_111_13)

				local var_111_15 = manager.ui.mainCamera.transform.position - var_111_10.position

				var_111_10.forward = Vector3.New(var_111_15.x, var_111_15.y, var_111_15.z)

				local var_111_16 = var_111_10.localEulerAngles

				var_111_16.z = 0
				var_111_16.x = 0
				var_111_10.localEulerAngles = var_111_16
			end

			if arg_108_1.time_ >= var_111_11 + var_111_12 and arg_108_1.time_ < var_111_11 + var_111_12 + arg_111_0 then
				var_111_10.localPosition = Vector3.New(0, 100, 0)

				local var_111_17 = manager.ui.mainCamera.transform.position - var_111_10.position

				var_111_10.forward = Vector3.New(var_111_17.x, var_111_17.y, var_111_17.z)

				local var_111_18 = var_111_10.localEulerAngles

				var_111_18.z = 0
				var_111_18.x = 0
				var_111_10.localEulerAngles = var_111_18
			end

			local var_111_19 = arg_108_1.actors_["1011ui_story"].transform
			local var_111_20 = 0

			if var_111_20 < arg_108_1.time_ and arg_108_1.time_ <= var_111_20 + arg_111_0 then
				arg_108_1.var_.moveOldPos1011ui_story = var_111_19.localPosition
			end

			local var_111_21 = 0.001

			if var_111_20 <= arg_108_1.time_ and arg_108_1.time_ < var_111_20 + var_111_21 then
				local var_111_22 = (arg_108_1.time_ - var_111_20) / var_111_21
				local var_111_23 = Vector3.New(0, -0.71, -6)

				var_111_19.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1011ui_story, var_111_23, var_111_22)

				local var_111_24 = manager.ui.mainCamera.transform.position - var_111_19.position

				var_111_19.forward = Vector3.New(var_111_24.x, var_111_24.y, var_111_24.z)

				local var_111_25 = var_111_19.localEulerAngles

				var_111_25.z = 0
				var_111_25.x = 0
				var_111_19.localEulerAngles = var_111_25
			end

			if arg_108_1.time_ >= var_111_20 + var_111_21 and arg_108_1.time_ < var_111_20 + var_111_21 + arg_111_0 then
				var_111_19.localPosition = Vector3.New(0, -0.71, -6)

				local var_111_26 = manager.ui.mainCamera.transform.position - var_111_19.position

				var_111_19.forward = Vector3.New(var_111_26.x, var_111_26.y, var_111_26.z)

				local var_111_27 = var_111_19.localEulerAngles

				var_111_27.z = 0
				var_111_27.x = 0
				var_111_19.localEulerAngles = var_111_27
			end

			local var_111_28 = 0

			if var_111_28 < arg_108_1.time_ and arg_108_1.time_ <= var_111_28 + arg_111_0 then
				arg_108_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_111_29 = 0

			if var_111_29 < arg_108_1.time_ and arg_108_1.time_ <= var_111_29 + arg_111_0 then
				arg_108_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_111_30 = 0
			local var_111_31 = 0.4

			if var_111_30 < arg_108_1.time_ and arg_108_1.time_ <= var_111_30 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_32 = arg_108_1:FormatText(StoryNameCfg[37].name)

				arg_108_1.leftNameTxt_.text = var_111_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_33 = arg_108_1:GetWordFromCfg(102081027)
				local var_111_34 = arg_108_1:FormatText(var_111_33.content)

				arg_108_1.text_.text = var_111_34

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_35 = 16
				local var_111_36 = utf8.len(var_111_34)
				local var_111_37 = var_111_35 <= 0 and var_111_31 or var_111_31 * (var_111_36 / var_111_35)

				if var_111_37 > 0 and var_111_31 < var_111_37 then
					arg_108_1.talkMaxDuration = var_111_37

					if var_111_37 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_37 + var_111_30
					end
				end

				arg_108_1.text_.text = var_111_34
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081027", "story_v_out_102081.awb") ~= 0 then
					local var_111_38 = manager.audio:GetVoiceLength("story_v_out_102081", "102081027", "story_v_out_102081.awb") / 1000

					if var_111_38 + var_111_30 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_38 + var_111_30
					end

					if var_111_33.prefab_name ~= "" and arg_108_1.actors_[var_111_33.prefab_name] ~= nil then
						local var_111_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_33.prefab_name].transform, "story_v_out_102081", "102081027", "story_v_out_102081.awb")

						arg_108_1:RecordAudio("102081027", var_111_39)
						arg_108_1:RecordAudio("102081027", var_111_39)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102081", "102081027", "story_v_out_102081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102081", "102081027", "story_v_out_102081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_40 = math.max(var_111_31, arg_108_1.talkMaxDuration)

			if var_111_30 <= arg_108_1.time_ and arg_108_1.time_ < var_111_30 + var_111_40 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_30) / var_111_40

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_30 + var_111_40 and arg_108_1.time_ < var_111_30 + var_111_40 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play102081028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102081028
		arg_112_1.duration_ = 9.3

		local var_112_0 = {
			ja = 9.3,
			ko = 4.066,
			zh = 4.633,
			en = 3.666
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play102081029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 1

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				local var_115_2 = "play"
				local var_115_3 = "music"

				arg_112_1:AudioAction(var_115_2, var_115_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_115_4 = ""
				local var_115_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_115_5 ~= "" then
					if arg_112_1.bgmTxt_.text ~= var_115_5 and arg_112_1.bgmTxt_.text ~= "" then
						if arg_112_1.bgmTxt2_.text ~= "" then
							arg_112_1.bgmTxt_.text = arg_112_1.bgmTxt2_.text
						end

						arg_112_1.bgmTxt2_.text = var_115_5

						arg_112_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_112_1.bgmTxt_.text = var_115_5
						arg_112_1.bgmTxt2_.text = var_115_5
					end

					if arg_112_1.bgmTimer then
						arg_112_1.bgmTimer:Stop()

						arg_112_1.bgmTimer = nil
					end

					if arg_112_1.settingData.show_music_name == 1 then
						arg_112_1.musicController:SetSelectedState("show")
						arg_112_1.musicAnimator_:Play("open", 0, 0)

						if arg_112_1.settingData.music_time ~= 0 then
							arg_112_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_112_1.settingData.music_time), function()
								if arg_112_1 == nil or isNil(arg_112_1.bgmTxt_) then
									return
								end

								arg_112_1.musicController:SetSelectedState("hide")
								arg_112_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_115_6 = 0
			local var_115_7 = 1

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				local var_115_8 = "play"
				local var_115_9 = "effect"

				arg_112_1:AudioAction(var_115_8, var_115_9, "se_story", "se_story_robot_long", "")
			end

			local var_115_10 = arg_112_1.actors_["1011ui_story"]
			local var_115_11 = 0

			if var_115_11 < arg_112_1.time_ and arg_112_1.time_ <= var_115_11 + arg_115_0 and not isNil(var_115_10) and arg_112_1.var_.characterEffect1011ui_story == nil then
				arg_112_1.var_.characterEffect1011ui_story = var_115_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_12 = 0.1

			if var_115_11 <= arg_112_1.time_ and arg_112_1.time_ < var_115_11 + var_115_12 and not isNil(var_115_10) then
				local var_115_13 = (arg_112_1.time_ - var_115_11) / var_115_12

				if arg_112_1.var_.characterEffect1011ui_story and not isNil(var_115_10) then
					local var_115_14 = Mathf.Lerp(0, 0.5, var_115_13)

					arg_112_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1011ui_story.fillRatio = var_115_14
				end
			end

			if arg_112_1.time_ >= var_115_11 + var_115_12 and arg_112_1.time_ < var_115_11 + var_115_12 + arg_115_0 and not isNil(var_115_10) and arg_112_1.var_.characterEffect1011ui_story then
				local var_115_15 = 0.5

				arg_112_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1011ui_story.fillRatio = var_115_15
			end

			local var_115_16 = arg_112_1.actors_["1011ui_story"].transform
			local var_115_17 = 0

			if var_115_17 < arg_112_1.time_ and arg_112_1.time_ <= var_115_17 + arg_115_0 then
				arg_112_1.var_.moveOldPos1011ui_story = var_115_16.localPosition
			end

			local var_115_18 = 0.001

			if var_115_17 <= arg_112_1.time_ and arg_112_1.time_ < var_115_17 + var_115_18 then
				local var_115_19 = (arg_112_1.time_ - var_115_17) / var_115_18
				local var_115_20 = Vector3.New(0, 100, 0)

				var_115_16.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1011ui_story, var_115_20, var_115_19)

				local var_115_21 = manager.ui.mainCamera.transform.position - var_115_16.position

				var_115_16.forward = Vector3.New(var_115_21.x, var_115_21.y, var_115_21.z)

				local var_115_22 = var_115_16.localEulerAngles

				var_115_22.z = 0
				var_115_22.x = 0
				var_115_16.localEulerAngles = var_115_22
			end

			if arg_112_1.time_ >= var_115_17 + var_115_18 and arg_112_1.time_ < var_115_17 + var_115_18 + arg_115_0 then
				var_115_16.localPosition = Vector3.New(0, 100, 0)

				local var_115_23 = manager.ui.mainCamera.transform.position - var_115_16.position

				var_115_16.forward = Vector3.New(var_115_23.x, var_115_23.y, var_115_23.z)

				local var_115_24 = var_115_16.localEulerAngles

				var_115_24.z = 0
				var_115_24.x = 0
				var_115_16.localEulerAngles = var_115_24
			end

			local var_115_25 = 0
			local var_115_26 = 0.375

			if var_115_25 < arg_112_1.time_ and arg_112_1.time_ <= var_115_25 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_27 = arg_112_1:FormatText(StoryNameCfg[29].name)

				arg_112_1.leftNameTxt_.text = var_115_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2018")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_28 = arg_112_1:GetWordFromCfg(102081028)
				local var_115_29 = arg_112_1:FormatText(var_115_28.content)

				arg_112_1.text_.text = var_115_29

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_30 = 15
				local var_115_31 = utf8.len(var_115_29)
				local var_115_32 = var_115_30 <= 0 and var_115_26 or var_115_26 * (var_115_31 / var_115_30)

				if var_115_32 > 0 and var_115_26 < var_115_32 then
					arg_112_1.talkMaxDuration = var_115_32

					if var_115_32 + var_115_25 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_32 + var_115_25
					end
				end

				arg_112_1.text_.text = var_115_29
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081028", "story_v_out_102081.awb") ~= 0 then
					local var_115_33 = manager.audio:GetVoiceLength("story_v_out_102081", "102081028", "story_v_out_102081.awb") / 1000

					if var_115_33 + var_115_25 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_33 + var_115_25
					end

					if var_115_28.prefab_name ~= "" and arg_112_1.actors_[var_115_28.prefab_name] ~= nil then
						local var_115_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_28.prefab_name].transform, "story_v_out_102081", "102081028", "story_v_out_102081.awb")

						arg_112_1:RecordAudio("102081028", var_115_34)
						arg_112_1:RecordAudio("102081028", var_115_34)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102081", "102081028", "story_v_out_102081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102081", "102081028", "story_v_out_102081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_35 = math.max(var_115_26, arg_112_1.talkMaxDuration)

			if var_115_25 <= arg_112_1.time_ and arg_112_1.time_ < var_115_25 + var_115_35 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_25) / var_115_35

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_25 + var_115_35 and arg_112_1.time_ < var_115_25 + var_115_35 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play102081029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 102081029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play102081030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.525

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(102081029)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 21
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play102081030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 102081030
		arg_121_1.duration_ = 3.67

		local var_121_0 = {
			ja = 2.9,
			ko = 2.733,
			zh = 2.966,
			en = 3.666
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play102081031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10002ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10002ui_story == nil then
				arg_121_1.var_.characterEffect10002ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.1

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10002ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10002ui_story then
				arg_121_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_124_5 = arg_121_1.actors_["10002ui_story"].transform
			local var_124_6 = 0

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.var_.moveOldPos10002ui_story = var_124_5.localPosition
			end

			local var_124_7 = 0.001

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_7 then
				local var_124_8 = (arg_121_1.time_ - var_124_6) / var_124_7
				local var_124_9 = Vector3.New(0, -1.2, -5.8)

				var_124_5.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10002ui_story, var_124_9, var_124_8)

				local var_124_10 = manager.ui.mainCamera.transform.position - var_124_5.position

				var_124_5.forward = Vector3.New(var_124_10.x, var_124_10.y, var_124_10.z)

				local var_124_11 = var_124_5.localEulerAngles

				var_124_11.z = 0
				var_124_11.x = 0
				var_124_5.localEulerAngles = var_124_11
			end

			if arg_121_1.time_ >= var_124_6 + var_124_7 and arg_121_1.time_ < var_124_6 + var_124_7 + arg_124_0 then
				var_124_5.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_124_12 = manager.ui.mainCamera.transform.position - var_124_5.position

				var_124_5.forward = Vector3.New(var_124_12.x, var_124_12.y, var_124_12.z)

				local var_124_13 = var_124_5.localEulerAngles

				var_124_13.z = 0
				var_124_13.x = 0
				var_124_5.localEulerAngles = var_124_13
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_124_15 = 0
			local var_124_16 = 0.375

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[39].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(102081030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 15
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081030", "story_v_out_102081.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_102081", "102081030", "story_v_out_102081.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_102081", "102081030", "story_v_out_102081.awb")

						arg_121_1:RecordAudio("102081030", var_124_24)
						arg_121_1:RecordAudio("102081030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_102081", "102081030", "story_v_out_102081.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_102081", "102081030", "story_v_out_102081.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play102081031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 102081031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play102081032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10002ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10002ui_story == nil then
				arg_125_1.var_.characterEffect10002ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.1

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10002ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10002ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10002ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10002ui_story.fillRatio = var_128_5
			end

			local var_128_6 = arg_125_1.actors_["10002ui_story"].transform
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.var_.moveOldPos10002ui_story = var_128_6.localPosition
			end

			local var_128_8 = 0.001

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_8 then
				local var_128_9 = (arg_125_1.time_ - var_128_7) / var_128_8
				local var_128_10 = Vector3.New(0, 100, 0)

				var_128_6.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10002ui_story, var_128_10, var_128_9)

				local var_128_11 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_11.x, var_128_11.y, var_128_11.z)

				local var_128_12 = var_128_6.localEulerAngles

				var_128_12.z = 0
				var_128_12.x = 0
				var_128_6.localEulerAngles = var_128_12
			end

			if arg_125_1.time_ >= var_128_7 + var_128_8 and arg_125_1.time_ < var_128_7 + var_128_8 + arg_128_0 then
				var_128_6.localPosition = Vector3.New(0, 100, 0)

				local var_128_13 = manager.ui.mainCamera.transform.position - var_128_6.position

				var_128_6.forward = Vector3.New(var_128_13.x, var_128_13.y, var_128_13.z)

				local var_128_14 = var_128_6.localEulerAngles

				var_128_14.z = 0
				var_128_14.x = 0
				var_128_6.localEulerAngles = var_128_14
			end

			local var_128_15 = 0
			local var_128_16 = 1.175

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_17 = arg_125_1:GetWordFromCfg(102081031)
				local var_128_18 = arg_125_1:FormatText(var_128_17.content)

				arg_125_1.text_.text = var_128_18

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_19 = 47
				local var_128_20 = utf8.len(var_128_18)
				local var_128_21 = var_128_19 <= 0 and var_128_16 or var_128_16 * (var_128_20 / var_128_19)

				if var_128_21 > 0 and var_128_16 < var_128_21 then
					arg_125_1.talkMaxDuration = var_128_21

					if var_128_21 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_21 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_18
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_22 and arg_125_1.time_ < var_128_15 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play102081032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 102081032
		arg_129_1.duration_ = 3.57

		local var_129_0 = {
			ja = 3.033,
			ko = 3.566,
			zh = 2.3,
			en = 3.2
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play102081033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1084ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.1

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["1084ui_story"].transform
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.var_.moveOldPos1084ui_story = var_132_4.localPosition

				local var_132_6 = "1084ui_story"

				arg_129_1:ShowWeapon(arg_129_1.var_[var_132_6 .. "Animator"].transform, false)
			end

			local var_132_7 = 0.001

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_7 then
				local var_132_8 = (arg_129_1.time_ - var_132_5) / var_132_7
				local var_132_9 = Vector3.New(0, -0.97, -6)

				var_132_4.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1084ui_story, var_132_9, var_132_8)

				local var_132_10 = manager.ui.mainCamera.transform.position - var_132_4.position

				var_132_4.forward = Vector3.New(var_132_10.x, var_132_10.y, var_132_10.z)

				local var_132_11 = var_132_4.localEulerAngles

				var_132_11.z = 0
				var_132_11.x = 0
				var_132_4.localEulerAngles = var_132_11
			end

			if arg_129_1.time_ >= var_132_5 + var_132_7 and arg_129_1.time_ < var_132_5 + var_132_7 + arg_132_0 then
				var_132_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_132_12 = manager.ui.mainCamera.transform.position - var_132_4.position

				var_132_4.forward = Vector3.New(var_132_12.x, var_132_12.y, var_132_12.z)

				local var_132_13 = var_132_4.localEulerAngles

				var_132_13.z = 0
				var_132_13.x = 0
				var_132_4.localEulerAngles = var_132_13
			end

			local var_132_14 = 0

			if var_132_14 < arg_129_1.time_ and arg_129_1.time_ <= var_132_14 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_132_15 = 0

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_132_16 = 0
			local var_132_17 = 0.3

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_18 = arg_129_1:FormatText(StoryNameCfg[6].name)

				arg_129_1.leftNameTxt_.text = var_132_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_19 = arg_129_1:GetWordFromCfg(102081032)
				local var_132_20 = arg_129_1:FormatText(var_132_19.content)

				arg_129_1.text_.text = var_132_20

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_21 = 12
				local var_132_22 = utf8.len(var_132_20)
				local var_132_23 = var_132_21 <= 0 and var_132_17 or var_132_17 * (var_132_22 / var_132_21)

				if var_132_23 > 0 and var_132_17 < var_132_23 then
					arg_129_1.talkMaxDuration = var_132_23

					if var_132_23 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_16
					end
				end

				arg_129_1.text_.text = var_132_20
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081032", "story_v_out_102081.awb") ~= 0 then
					local var_132_24 = manager.audio:GetVoiceLength("story_v_out_102081", "102081032", "story_v_out_102081.awb") / 1000

					if var_132_24 + var_132_16 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_24 + var_132_16
					end

					if var_132_19.prefab_name ~= "" and arg_129_1.actors_[var_132_19.prefab_name] ~= nil then
						local var_132_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_19.prefab_name].transform, "story_v_out_102081", "102081032", "story_v_out_102081.awb")

						arg_129_1:RecordAudio("102081032", var_132_25)
						arg_129_1:RecordAudio("102081032", var_132_25)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_102081", "102081032", "story_v_out_102081.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_102081", "102081032", "story_v_out_102081.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_26 = math.max(var_132_17, arg_129_1.talkMaxDuration)

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_26 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_16) / var_132_26

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_16 + var_132_26 and arg_129_1.time_ < var_132_16 + var_132_26 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play102081033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 102081033
		arg_133_1.duration_ = 9.57

		local var_133_0 = {
			ja = 9.566,
			ko = 4.4,
			zh = 6.233,
			en = 4.366
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play102081034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_2 = "play"
				local var_136_3 = "effect"

				arg_133_1:AudioAction(var_136_2, var_136_3, "se_story", "se_story_robot_long", "")
			end

			local var_136_4 = arg_133_1.actors_["2022_tpose"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect2022_tpose == nil then
				arg_133_1.var_.characterEffect2022_tpose = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.1

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect2022_tpose and not isNil(var_136_4) then
					arg_133_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect2022_tpose then
				arg_133_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_136_8 = "2021_tpose"

			if arg_133_1.actors_[var_136_8] == nil then
				local var_136_9 = Asset.Load("Char/" .. "2021_tpose")

				if not isNil(var_136_9) then
					local var_136_10 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_133_1.stage_.transform)

					var_136_10.name = var_136_8
					var_136_10.transform.localPosition = Vector3.New(0, 100, 0)
					arg_133_1.actors_[var_136_8] = var_136_10

					local var_136_11 = var_136_10:GetComponentInChildren(typeof(CharacterEffect))

					var_136_11.enabled = true

					local var_136_12 = GameObjectTools.GetOrAddComponent(var_136_10, typeof(DynamicBoneHelper))

					if var_136_12 then
						var_136_12:EnableDynamicBone(false)
					end

					arg_133_1:ShowWeapon(var_136_11.transform, false)

					arg_133_1.var_[var_136_8 .. "Animator"] = var_136_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_133_1.var_[var_136_8 .. "Animator"].applyRootMotion = true
					arg_133_1.var_[var_136_8 .. "LipSync"] = var_136_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_136_13 = arg_133_1.actors_["2021_tpose"]
			local var_136_14 = 0

			if var_136_14 < arg_133_1.time_ and arg_133_1.time_ <= var_136_14 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect2021_tpose == nil then
				arg_133_1.var_.characterEffect2021_tpose = var_136_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_15 = 0.1

			if var_136_14 <= arg_133_1.time_ and arg_133_1.time_ < var_136_14 + var_136_15 and not isNil(var_136_13) then
				local var_136_16 = (arg_133_1.time_ - var_136_14) / var_136_15

				if arg_133_1.var_.characterEffect2021_tpose and not isNil(var_136_13) then
					arg_133_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_14 + var_136_15 and arg_133_1.time_ < var_136_14 + var_136_15 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect2021_tpose then
				arg_133_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_136_17 = arg_133_1.actors_["1084ui_story"]
			local var_136_18 = 0

			if var_136_18 < arg_133_1.time_ and arg_133_1.time_ <= var_136_18 + arg_136_0 and not isNil(var_136_17) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_19 = 0.1

			if var_136_18 <= arg_133_1.time_ and arg_133_1.time_ < var_136_18 + var_136_19 and not isNil(var_136_17) then
				local var_136_20 = (arg_133_1.time_ - var_136_18) / var_136_19

				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_17) then
					local var_136_21 = Mathf.Lerp(0, 0.5, var_136_20)

					arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1084ui_story.fillRatio = var_136_21
				end
			end

			if arg_133_1.time_ >= var_136_18 + var_136_19 and arg_133_1.time_ < var_136_18 + var_136_19 + arg_136_0 and not isNil(var_136_17) and arg_133_1.var_.characterEffect1084ui_story then
				local var_136_22 = 0.5

				arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1084ui_story.fillRatio = var_136_22
			end

			local var_136_23 = arg_133_1.actors_["1084ui_story"].transform
			local var_136_24 = 0

			if var_136_24 < arg_133_1.time_ and arg_133_1.time_ <= var_136_24 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_23.localPosition
			end

			local var_136_25 = 0.001

			if var_136_24 <= arg_133_1.time_ and arg_133_1.time_ < var_136_24 + var_136_25 then
				local var_136_26 = (arg_133_1.time_ - var_136_24) / var_136_25
				local var_136_27 = Vector3.New(0, 100, 0)

				var_136_23.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, var_136_27, var_136_26)

				local var_136_28 = manager.ui.mainCamera.transform.position - var_136_23.position

				var_136_23.forward = Vector3.New(var_136_28.x, var_136_28.y, var_136_28.z)

				local var_136_29 = var_136_23.localEulerAngles

				var_136_29.z = 0
				var_136_29.x = 0
				var_136_23.localEulerAngles = var_136_29
			end

			if arg_133_1.time_ >= var_136_24 + var_136_25 and arg_133_1.time_ < var_136_24 + var_136_25 + arg_136_0 then
				var_136_23.localPosition = Vector3.New(0, 100, 0)

				local var_136_30 = manager.ui.mainCamera.transform.position - var_136_23.position

				var_136_23.forward = Vector3.New(var_136_30.x, var_136_30.y, var_136_30.z)

				local var_136_31 = var_136_23.localEulerAngles

				var_136_31.z = 0
				var_136_31.x = 0
				var_136_23.localEulerAngles = var_136_31
			end

			local var_136_32 = arg_133_1.actors_["2021_tpose"].transform
			local var_136_33 = 0

			if var_136_33 < arg_133_1.time_ and arg_133_1.time_ <= var_136_33 + arg_136_0 then
				arg_133_1.var_.moveOldPos2021_tpose = var_136_32.localPosition

				local var_136_34 = GameObjectTools.GetOrAddComponent(var_136_32.gameObject, typeof(DynamicBoneHelper))

				if var_136_34 then
					var_136_34:EnableDynamicBone(false)
				end
			end

			local var_136_35 = 0.001

			if var_136_33 <= arg_133_1.time_ and arg_133_1.time_ < var_136_33 + var_136_35 then
				local var_136_36 = (arg_133_1.time_ - var_136_33) / var_136_35
				local var_136_37 = Vector3.New(-1.92, -0.6, 0.2)

				var_136_32.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos2021_tpose, var_136_37, var_136_36)

				local var_136_38 = manager.ui.mainCamera.transform.position - var_136_32.position

				var_136_32.forward = Vector3.New(var_136_38.x, var_136_38.y, var_136_38.z)

				local var_136_39 = var_136_32.localEulerAngles

				var_136_39.z = 0
				var_136_39.x = 0
				var_136_32.localEulerAngles = var_136_39
			end

			if arg_133_1.time_ >= var_136_33 + var_136_35 and arg_133_1.time_ < var_136_33 + var_136_35 + arg_136_0 then
				var_136_32.localPosition = Vector3.New(-1.92, -0.6, 0.2)

				local var_136_40 = manager.ui.mainCamera.transform.position - var_136_32.position

				var_136_32.forward = Vector3.New(var_136_40.x, var_136_40.y, var_136_40.z)

				local var_136_41 = var_136_32.localEulerAngles

				var_136_41.z = 0
				var_136_41.x = 0
				var_136_32.localEulerAngles = var_136_41

				local var_136_42 = GameObjectTools.GetOrAddComponent(var_136_32.gameObject, typeof(DynamicBoneHelper))

				if var_136_42 then
					var_136_42:EnableDynamicBone(true)
				end
			end

			local var_136_43 = 0

			if var_136_43 < arg_133_1.time_ and arg_133_1.time_ <= var_136_43 + arg_136_0 then
				arg_133_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_136_44 = arg_133_1.actors_["2022_tpose"].transform
			local var_136_45 = 0

			if var_136_45 < arg_133_1.time_ and arg_133_1.time_ <= var_136_45 + arg_136_0 then
				arg_133_1.var_.moveOldPos2022_tpose = var_136_44.localPosition

				local var_136_46 = GameObjectTools.GetOrAddComponent(var_136_44.gameObject, typeof(DynamicBoneHelper))

				if var_136_46 then
					var_136_46:EnableDynamicBone(false)
				end
			end

			local var_136_47 = 0.001

			if var_136_45 <= arg_133_1.time_ and arg_133_1.time_ < var_136_45 + var_136_47 then
				local var_136_48 = (arg_133_1.time_ - var_136_45) / var_136_47
				local var_136_49 = Vector3.New(0.7, -0.55, -0.3)

				var_136_44.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos2022_tpose, var_136_49, var_136_48)

				local var_136_50 = manager.ui.mainCamera.transform.position - var_136_44.position

				var_136_44.forward = Vector3.New(var_136_50.x, var_136_50.y, var_136_50.z)

				local var_136_51 = var_136_44.localEulerAngles

				var_136_51.z = 0
				var_136_51.x = 0
				var_136_44.localEulerAngles = var_136_51
			end

			if arg_133_1.time_ >= var_136_45 + var_136_47 and arg_133_1.time_ < var_136_45 + var_136_47 + arg_136_0 then
				var_136_44.localPosition = Vector3.New(0.7, -0.55, -0.3)

				local var_136_52 = manager.ui.mainCamera.transform.position - var_136_44.position

				var_136_44.forward = Vector3.New(var_136_52.x, var_136_52.y, var_136_52.z)

				local var_136_53 = var_136_44.localEulerAngles

				var_136_53.z = 0
				var_136_53.x = 0
				var_136_44.localEulerAngles = var_136_53

				local var_136_54 = GameObjectTools.GetOrAddComponent(var_136_44.gameObject, typeof(DynamicBoneHelper))

				if var_136_54 then
					var_136_54:EnableDynamicBone(true)
				end
			end

			local var_136_55 = 0

			if var_136_55 < arg_133_1.time_ and arg_133_1.time_ <= var_136_55 + arg_136_0 then
				arg_133_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_136_56 = 0
			local var_136_57 = 0.45

			if var_136_56 < arg_133_1.time_ and arg_133_1.time_ <= var_136_56 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_58 = arg_133_1:FormatText(StoryNameCfg[29].name)

				arg_133_1.leftNameTxt_.text = var_136_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_59 = arg_133_1:GetWordFromCfg(102081033)
				local var_136_60 = arg_133_1:FormatText(var_136_59.content)

				arg_133_1.text_.text = var_136_60

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_61 = 18
				local var_136_62 = utf8.len(var_136_60)
				local var_136_63 = var_136_61 <= 0 and var_136_57 or var_136_57 * (var_136_62 / var_136_61)

				if var_136_63 > 0 and var_136_57 < var_136_63 then
					arg_133_1.talkMaxDuration = var_136_63

					if var_136_63 + var_136_56 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_63 + var_136_56
					end
				end

				arg_133_1.text_.text = var_136_60
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081033", "story_v_out_102081.awb") ~= 0 then
					local var_136_64 = manager.audio:GetVoiceLength("story_v_out_102081", "102081033", "story_v_out_102081.awb") / 1000

					if var_136_64 + var_136_56 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_64 + var_136_56
					end

					if var_136_59.prefab_name ~= "" and arg_133_1.actors_[var_136_59.prefab_name] ~= nil then
						local var_136_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_59.prefab_name].transform, "story_v_out_102081", "102081033", "story_v_out_102081.awb")

						arg_133_1:RecordAudio("102081033", var_136_65)
						arg_133_1:RecordAudio("102081033", var_136_65)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_102081", "102081033", "story_v_out_102081.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_102081", "102081033", "story_v_out_102081.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_66 = math.max(var_136_57, arg_133_1.talkMaxDuration)

			if var_136_56 <= arg_133_1.time_ and arg_133_1.time_ < var_136_56 + var_136_66 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_56) / var_136_66

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_56 + var_136_66 and arg_133_1.time_ < var_136_56 + var_136_66 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play102081034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 102081034
		arg_137_1.duration_ = 3.53

		local var_137_0 = {
			ja = 3.466,
			ko = 3.133,
			zh = 3.433,
			en = 3.533
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play102081035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1019ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1019ui_story == nil then
				arg_137_1.var_.characterEffect1019ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.1

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1019ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1019ui_story then
				arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["2022_tpose"]
			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect2022_tpose == nil then
				arg_137_1.var_.characterEffect2022_tpose = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.1

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 and not isNil(var_140_4) then
				local var_140_7 = (arg_137_1.time_ - var_140_5) / var_140_6

				if arg_137_1.var_.characterEffect2022_tpose and not isNil(var_140_4) then
					local var_140_8 = Mathf.Lerp(0, 0.5, var_140_7)

					arg_137_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_137_1.var_.characterEffect2022_tpose.fillRatio = var_140_8
				end
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect2022_tpose then
				local var_140_9 = 0.5

				arg_137_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_137_1.var_.characterEffect2022_tpose.fillRatio = var_140_9
			end

			local var_140_10 = arg_137_1.actors_["2021_tpose"]
			local var_140_11 = 0

			if var_140_11 < arg_137_1.time_ and arg_137_1.time_ <= var_140_11 + arg_140_0 and not isNil(var_140_10) and arg_137_1.var_.characterEffect2021_tpose == nil then
				arg_137_1.var_.characterEffect2021_tpose = var_140_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_12 = 0.1

			if var_140_11 <= arg_137_1.time_ and arg_137_1.time_ < var_140_11 + var_140_12 and not isNil(var_140_10) then
				local var_140_13 = (arg_137_1.time_ - var_140_11) / var_140_12

				if arg_137_1.var_.characterEffect2021_tpose and not isNil(var_140_10) then
					local var_140_14 = Mathf.Lerp(0, 0.5, var_140_13)

					arg_137_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_137_1.var_.characterEffect2021_tpose.fillRatio = var_140_14
				end
			end

			if arg_137_1.time_ >= var_140_11 + var_140_12 and arg_137_1.time_ < var_140_11 + var_140_12 + arg_140_0 and not isNil(var_140_10) and arg_137_1.var_.characterEffect2021_tpose then
				local var_140_15 = 0.5

				arg_137_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_137_1.var_.characterEffect2021_tpose.fillRatio = var_140_15
			end

			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_140_17 = 0
			local var_140_18 = 0.45

			if var_140_17 < arg_137_1.time_ and arg_137_1.time_ <= var_140_17 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_19 = arg_137_1:FormatText(StoryNameCfg[13].name)

				arg_137_1.leftNameTxt_.text = var_140_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_20 = arg_137_1:GetWordFromCfg(102081034)
				local var_140_21 = arg_137_1:FormatText(var_140_20.content)

				arg_137_1.text_.text = var_140_21

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_22 = 18
				local var_140_23 = utf8.len(var_140_21)
				local var_140_24 = var_140_22 <= 0 and var_140_18 or var_140_18 * (var_140_23 / var_140_22)

				if var_140_24 > 0 and var_140_18 < var_140_24 then
					arg_137_1.talkMaxDuration = var_140_24

					if var_140_24 + var_140_17 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_24 + var_140_17
					end
				end

				arg_137_1.text_.text = var_140_21
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081034", "story_v_out_102081.awb") ~= 0 then
					local var_140_25 = manager.audio:GetVoiceLength("story_v_out_102081", "102081034", "story_v_out_102081.awb") / 1000

					if var_140_25 + var_140_17 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_25 + var_140_17
					end

					if var_140_20.prefab_name ~= "" and arg_137_1.actors_[var_140_20.prefab_name] ~= nil then
						local var_140_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_20.prefab_name].transform, "story_v_out_102081", "102081034", "story_v_out_102081.awb")

						arg_137_1:RecordAudio("102081034", var_140_26)
						arg_137_1:RecordAudio("102081034", var_140_26)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_102081", "102081034", "story_v_out_102081.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_102081", "102081034", "story_v_out_102081.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_27 = math.max(var_140_18, arg_137_1.talkMaxDuration)

			if var_140_17 <= arg_137_1.time_ and arg_137_1.time_ < var_140_17 + var_140_27 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_17) / var_140_27

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_17 + var_140_27 and arg_137_1.time_ < var_140_17 + var_140_27 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play102081035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 102081035
		arg_141_1.duration_ = 6

		local var_141_0 = {
			ja = 3.566,
			ko = 4,
			zh = 6,
			en = 3.433
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
			arg_141_1.auto_ = false
		end

		function arg_141_1.playNext_(arg_143_0)
			arg_141_1.onStoryFinished_()
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10002ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10002ui_story == nil then
				arg_141_1.var_.characterEffect10002ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.1

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10002ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10002ui_story then
				arg_141_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["2021_tpose"].transform
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.var_.moveOldPos2021_tpose = var_144_4.localPosition

				local var_144_6 = GameObjectTools.GetOrAddComponent(var_144_4.gameObject, typeof(DynamicBoneHelper))

				if var_144_6 then
					var_144_6:EnableDynamicBone(false)
				end
			end

			local var_144_7 = 0.001

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_7 then
				local var_144_8 = (arg_141_1.time_ - var_144_5) / var_144_7
				local var_144_9 = Vector3.New(10, -0.6, 0.2)

				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2021_tpose, var_144_9, var_144_8)

				local var_144_10 = manager.ui.mainCamera.transform.position - var_144_4.position

				var_144_4.forward = Vector3.New(var_144_10.x, var_144_10.y, var_144_10.z)

				local var_144_11 = var_144_4.localEulerAngles

				var_144_11.z = 0
				var_144_11.x = 0
				var_144_4.localEulerAngles = var_144_11
			end

			if arg_141_1.time_ >= var_144_5 + var_144_7 and arg_141_1.time_ < var_144_5 + var_144_7 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(10, -0.6, 0.2)

				local var_144_12 = manager.ui.mainCamera.transform.position - var_144_4.position

				var_144_4.forward = Vector3.New(var_144_12.x, var_144_12.y, var_144_12.z)

				local var_144_13 = var_144_4.localEulerAngles

				var_144_13.z = 0
				var_144_13.x = 0
				var_144_4.localEulerAngles = var_144_13

				local var_144_14 = GameObjectTools.GetOrAddComponent(var_144_4.gameObject, typeof(DynamicBoneHelper))

				if var_144_14 then
					var_144_14:EnableDynamicBone(true)
				end
			end

			local var_144_15 = arg_141_1.actors_["2022_tpose"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos2022_tpose = var_144_15.localPosition

				local var_144_17 = GameObjectTools.GetOrAddComponent(var_144_15.gameObject, typeof(DynamicBoneHelper))

				if var_144_17 then
					var_144_17:EnableDynamicBone(false)
				end
			end

			local var_144_18 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_18 then
				local var_144_19 = (arg_141_1.time_ - var_144_16) / var_144_18
				local var_144_20 = Vector3.New(0, 100, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2022_tpose, var_144_20, var_144_19)

				local var_144_21 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_21.x, var_144_21.y, var_144_21.z)

				local var_144_22 = var_144_15.localEulerAngles

				var_144_22.z = 0
				var_144_22.x = 0
				var_144_15.localEulerAngles = var_144_22
			end

			if arg_141_1.time_ >= var_144_16 + var_144_18 and arg_141_1.time_ < var_144_16 + var_144_18 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, 100, 0)

				local var_144_23 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_23.x, var_144_23.y, var_144_23.z)

				local var_144_24 = var_144_15.localEulerAngles

				var_144_24.z = 0
				var_144_24.x = 0
				var_144_15.localEulerAngles = var_144_24

				local var_144_25 = GameObjectTools.GetOrAddComponent(var_144_15.gameObject, typeof(DynamicBoneHelper))

				if var_144_25 then
					var_144_25:EnableDynamicBone(true)
				end
			end

			local var_144_26 = arg_141_1.actors_["10002ui_story"].transform
			local var_144_27 = 0

			if var_144_27 < arg_141_1.time_ and arg_141_1.time_ <= var_144_27 + arg_144_0 then
				arg_141_1.var_.moveOldPos10002ui_story = var_144_26.localPosition
			end

			local var_144_28 = 0.001

			if var_144_27 <= arg_141_1.time_ and arg_141_1.time_ < var_144_27 + var_144_28 then
				local var_144_29 = (arg_141_1.time_ - var_144_27) / var_144_28
				local var_144_30 = Vector3.New(0, -1.2, -5.8)

				var_144_26.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10002ui_story, var_144_30, var_144_29)

				local var_144_31 = manager.ui.mainCamera.transform.position - var_144_26.position

				var_144_26.forward = Vector3.New(var_144_31.x, var_144_31.y, var_144_31.z)

				local var_144_32 = var_144_26.localEulerAngles

				var_144_32.z = 0
				var_144_32.x = 0
				var_144_26.localEulerAngles = var_144_32
			end

			if arg_141_1.time_ >= var_144_27 + var_144_28 and arg_141_1.time_ < var_144_27 + var_144_28 + arg_144_0 then
				var_144_26.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_144_33 = manager.ui.mainCamera.transform.position - var_144_26.position

				var_144_26.forward = Vector3.New(var_144_33.x, var_144_33.y, var_144_33.z)

				local var_144_34 = var_144_26.localEulerAngles

				var_144_34.z = 0
				var_144_34.x = 0
				var_144_26.localEulerAngles = var_144_34
			end

			local var_144_35 = 0

			if var_144_35 < arg_141_1.time_ and arg_141_1.time_ <= var_144_35 + arg_144_0 then
				arg_141_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_144_36 = 0

			if var_144_36 < arg_141_1.time_ and arg_141_1.time_ <= var_144_36 + arg_144_0 then
				arg_141_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_144_37 = 0
			local var_144_38 = 0.475

			if var_144_37 < arg_141_1.time_ and arg_141_1.time_ <= var_144_37 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_39 = arg_141_1:FormatText(StoryNameCfg[39].name)

				arg_141_1.leftNameTxt_.text = var_144_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_40 = arg_141_1:GetWordFromCfg(102081035)
				local var_144_41 = arg_141_1:FormatText(var_144_40.content)

				arg_141_1.text_.text = var_144_41

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_42 = 19
				local var_144_43 = utf8.len(var_144_41)
				local var_144_44 = var_144_42 <= 0 and var_144_38 or var_144_38 * (var_144_43 / var_144_42)

				if var_144_44 > 0 and var_144_38 < var_144_44 then
					arg_141_1.talkMaxDuration = var_144_44

					if var_144_44 + var_144_37 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_44 + var_144_37
					end
				end

				arg_141_1.text_.text = var_144_41
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081035", "story_v_out_102081.awb") ~= 0 then
					local var_144_45 = manager.audio:GetVoiceLength("story_v_out_102081", "102081035", "story_v_out_102081.awb") / 1000

					if var_144_45 + var_144_37 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_45 + var_144_37
					end

					if var_144_40.prefab_name ~= "" and arg_141_1.actors_[var_144_40.prefab_name] ~= nil then
						local var_144_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_40.prefab_name].transform, "story_v_out_102081", "102081035", "story_v_out_102081.awb")

						arg_141_1:RecordAudio("102081035", var_144_46)
						arg_141_1:RecordAudio("102081035", var_144_46)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_102081", "102081035", "story_v_out_102081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_102081", "102081035", "story_v_out_102081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_47 = math.max(var_144_38, arg_141_1.talkMaxDuration)

			if var_144_37 <= arg_141_1.time_ and arg_141_1.time_ < var_144_37 + var_144_47 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_37) / var_144_47

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_37 + var_144_47 and arg_141_1.time_ < var_144_37 + var_144_47 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2021_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2022_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02c"
	},
	voices = {
		"story_v_out_102081.awb"
	}
}
