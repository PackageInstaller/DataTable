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
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_3 = "2022_tpose"

			if arg_1_1.actors_["2022_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2022_tpose"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "2022_tpose"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["2022_tpose"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect2022_tpose == nil then
				arg_1_1.var_.characterEffect2022_tpose = var_4_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_8 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.characterEffect2022_tpose and not isNil(var_4_7) then
					arg_1_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect2022_tpose then
				arg_1_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_4_10 = "B02c"

			if arg_1_1.bgs_.B02c == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.B02c:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueB02c = var_4_12.color.a
					arg_1_1.var_.alphaMatValueB02c = var_4_12
				end

				arg_1_1.var_.alphaOldValueB02c = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueB02c then
					arg_1_1.var_.alphaMatValueB02c.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02c, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueB02c.color = arg_1_1.var_.alphaMatValueB02c.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueB02c then
				arg_1_1.var_.alphaMatValueB02c.color.a = 1
				arg_1_1.var_.alphaMatValueB02c.color = arg_1_1.var_.alphaMatValueB02c.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.B02c

				arg_1_1.bgs_.B02c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_17 = arg_1_1.actors_["2022_tpose"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos2022_tpose = var_4_17.localPosition

				local var_4_18 = GameObjectTools.GetOrAddComponent(var_4_17.gameObject, typeof(DynamicBoneHelper))

				if var_4_18 then
					var_4_18:EnableDynamicBone(false)
				end
			end

			local var_4_19 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_19 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2022_tpose, Vector3.New(0, -0.55, -0.3), (arg_1_1.time_ - 1.79999995231628) / var_4_19)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_19 and arg_1_1.time_ < 1.79999995231628 + var_4_19 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, -0.55, -0.3)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles

				local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_17.gameObject, typeof(DynamicBoneHelper))

				if var_4_20 then
					var_4_20:EnableDynamicBone(true)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_4_21 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_21 + 2 and arg_1_1.time_ < var_4_21 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(102081001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 15 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 15)

				if (15 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 15)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081001", "story_v_out_102081.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_102081", "102081001", "story_v_out_102081.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_102081", "102081001", "story_v_out_102081.awb")

						arg_1_1:RecordAudio("102081001", var_4_30)
						arg_1_1:RecordAudio("102081001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102081", "102081001", "story_v_out_102081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102081", "102081001", "story_v_out_102081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
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
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_10_1 = "2018_tpose"

			if arg_7_1.actors_["2018_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2018_tpose"))) then
				local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "2018_tpose"), arg_7_1.stage_.transform)

				var_10_2.name = var_10_1
				var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_1] = var_10_2

				local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

				var_10_3.enabled = true

				local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

				if var_10_4 then
					var_10_4:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_3.transform, false)

				arg_7_1.var_[var_10_1 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_1 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_1 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_5 = arg_7_1.actors_["2018_tpose"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect2018_tpose == nil then
				arg_7_1.var_.characterEffect2018_tpose = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect2018_tpose and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect2018_tpose.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect2018_tpose then
				arg_7_1.var_.characterEffect2018_tpose.fillFlat = false
			end

			local var_10_8 = arg_7_1.actors_["2022_tpose"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect2022_tpose == nil then
				arg_7_1.var_.characterEffect2022_tpose = var_10_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_9 = 0.1

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_9 and not isNil(var_10_8) then
				if arg_7_1.var_.characterEffect2022_tpose and not isNil(var_10_8) then
					arg_7_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_7_1.var_.characterEffect2022_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_9)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_9 and arg_7_1.time_ < 0 + var_10_9 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect2022_tpose then
				arg_7_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_7_1.var_.characterEffect2022_tpose.fillRatio = 0.5
			end

			local var_10_10 = arg_7_1.actors_["2022_tpose"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos2022_tpose = var_10_10.localPosition

				local var_10_11 = GameObjectTools.GetOrAddComponent(var_10_10.gameObject, typeof(DynamicBoneHelper))

				if var_10_11 then
					var_10_11:EnableDynamicBone(false)
				end
			end

			local var_10_12 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_12 then
				var_10_10.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2022_tpose, Vector3.New(0, 100, 0), (arg_7_1.time_ - 0) / var_10_12)
				var_10_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_10.position).x, (manager.ui.mainCamera.transform.position - var_10_10.position).y, (manager.ui.mainCamera.transform.position - var_10_10.position).z)
				var_10_10.localEulerAngles.z = 0
				var_10_10.localEulerAngles.x = 0
				var_10_10.localEulerAngles = var_10_10.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_12 and arg_7_1.time_ < 0 + var_10_12 + arg_10_0 then
				var_10_10.localPosition = Vector3.New(0, 100, 0)
				var_10_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_10.position).x, (manager.ui.mainCamera.transform.position - var_10_10.position).y, (manager.ui.mainCamera.transform.position - var_10_10.position).z)
				var_10_10.localEulerAngles.z = 0
				var_10_10.localEulerAngles.x = 0
				var_10_10.localEulerAngles = var_10_10.localEulerAngles

				local var_10_13 = GameObjectTools.GetOrAddComponent(var_10_10.gameObject, typeof(DynamicBoneHelper))

				if var_10_13 then
					var_10_13:EnableDynamicBone(true)
				end
			end

			local var_10_14 = arg_7_1.actors_["2018_tpose"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos2018_tpose = var_10_14.localPosition

				local var_10_15 = GameObjectTools.GetOrAddComponent(var_10_14.gameObject, typeof(DynamicBoneHelper))

				if var_10_15 then
					var_10_15:EnableDynamicBone(false)
				end
			end

			local var_10_16 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_16 then
				var_10_14.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos2018_tpose, Vector3.New(0, -0.5, -0.7), (arg_7_1.time_ - 0) / var_10_16)
				var_10_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_14.position).x, (manager.ui.mainCamera.transform.position - var_10_14.position).y, (manager.ui.mainCamera.transform.position - var_10_14.position).z)
				var_10_14.localEulerAngles.z = 0
				var_10_14.localEulerAngles.x = 0
				var_10_14.localEulerAngles = var_10_14.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_16 and arg_7_1.time_ < 0 + var_10_16 + arg_10_0 then
				var_10_14.localPosition = Vector3.New(0, -0.5, -0.7)
				var_10_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_14.position).x, (manager.ui.mainCamera.transform.position - var_10_14.position).y, (manager.ui.mainCamera.transform.position - var_10_14.position).z)
				var_10_14.localEulerAngles.z = 0
				var_10_14.localEulerAngles.x = 0
				var_10_14.localEulerAngles = var_10_14.localEulerAngles

				local var_10_17 = GameObjectTools.GetOrAddComponent(var_10_14.gameObject, typeof(DynamicBoneHelper))

				if var_10_17 then
					var_10_17:EnableDynamicBone(true)
				end
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("2018_tpose", "StoryTimeline/CharAction/story2018/story2018action/2018action1_1")
			end

			local var_10_18 = 0
			local var_10_19 = 0.3

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_18 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_20 = arg_7_1:GetWordFromCfg(102081002)
				local var_10_21 = arg_7_1:FormatText(var_10_20.content)

				arg_7_1.text_.text = var_10_21

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_23 = 12 <= 0 and var_10_19 or var_10_19 * (utf8.len(var_10_21) / 12)

				if (12 <= 0 and var_10_19 or var_10_19 * (utf8.len(var_10_21) / 12)) > 0 and var_10_19 < var_10_23 then
					arg_7_1.talkMaxDuration = var_10_23

					if var_10_23 + var_10_18 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_23 + var_10_18
					end
				end

				arg_7_1.text_.text = var_10_21
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081002", "story_v_out_102081.awb") ~= 0 then
					local var_10_24 = manager.audio:GetVoiceLength("story_v_out_102081", "102081002", "story_v_out_102081.awb") / 1000

					if var_10_24 + var_10_18 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_24 + var_10_18
					end

					if var_10_20.prefab_name ~= "" and arg_7_1.actors_[var_10_20.prefab_name] ~= nil then
						local var_10_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_20.prefab_name].transform, "story_v_out_102081", "102081002", "story_v_out_102081.awb")

						arg_7_1:RecordAudio("102081002", var_10_25)
						arg_7_1:RecordAudio("102081002", var_10_25)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_102081", "102081002", "story_v_out_102081.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_102081", "102081002", "story_v_out_102081.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_26 = math.max(var_10_19, arg_7_1.talkMaxDuration)

			if var_10_18 <= arg_7_1.time_ and arg_7_1.time_ < var_10_18 + var_10_26 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_18) / var_10_26

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_18 + var_10_26 and arg_7_1.time_ < var_10_18 + var_10_26 + arg_10_0 then
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
			if arg_11_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_14_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_11_1.stage_.transform)

				var_14_0.name = "1011ui_story"
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1011ui_story"] = var_14_0

				local var_14_1 = var_14_0:GetComponentInChildren(typeof(CharacterEffect))

				var_14_1.enabled = true

				local var_14_2 = GameObjectTools.GetOrAddComponent(var_14_0, typeof(DynamicBoneHelper))

				if var_14_2 then
					var_14_2:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_1.transform, false)

				arg_11_1.var_["1011ui_story" .. "Animator"] = var_14_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_11_1.var_["1011ui_story" .. "LipSync"] = var_14_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_3 = arg_11_1.actors_["1011ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1011ui_story == nil then
				arg_11_1.var_.characterEffect1011ui_story = var_14_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_4 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 and not isNil(var_14_3) then
				if arg_11_1.var_.characterEffect1011ui_story and not isNil(var_14_3) then
					arg_11_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1011ui_story then
				arg_11_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_14_6 = arg_11_1.actors_["2018_tpose"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_6) and arg_11_1.var_.characterEffect2018_tpose == nil then
				arg_11_1.var_.characterEffect2018_tpose = var_14_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_7 = 0.1

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_7 and not isNil(var_14_6) then
				if arg_11_1.var_.characterEffect2018_tpose and not isNil(var_14_6) then
					arg_11_1.var_.characterEffect2018_tpose.fillFlat = true
					arg_11_1.var_.characterEffect2018_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_7)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_7 and arg_11_1.time_ < 0 + var_14_7 + arg_14_0 and not isNil(var_14_6) and arg_11_1.var_.characterEffect2018_tpose then
				arg_11_1.var_.characterEffect2018_tpose.fillFlat = true
				arg_11_1.var_.characterEffect2018_tpose.fillRatio = 0.5
			end

			local var_14_8 = arg_11_1.actors_["2018_tpose"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos2018_tpose = var_14_8.localPosition

				local var_14_9 = GameObjectTools.GetOrAddComponent(var_14_8.gameObject, typeof(DynamicBoneHelper))

				if var_14_9 then
					var_14_9:EnableDynamicBone(false)
				end
			end

			local var_14_10 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_10 then
				var_14_8.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos2018_tpose, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_10)
				var_14_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_8.position).x, (manager.ui.mainCamera.transform.position - var_14_8.position).y, (manager.ui.mainCamera.transform.position - var_14_8.position).z)
				var_14_8.localEulerAngles.z = 0
				var_14_8.localEulerAngles.x = 0
				var_14_8.localEulerAngles = var_14_8.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_10 and arg_11_1.time_ < 0 + var_14_10 + arg_14_0 then
				var_14_8.localPosition = Vector3.New(0, 100, 0)
				var_14_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_8.position).x, (manager.ui.mainCamera.transform.position - var_14_8.position).y, (manager.ui.mainCamera.transform.position - var_14_8.position).z)
				var_14_8.localEulerAngles.z = 0
				var_14_8.localEulerAngles.x = 0
				var_14_8.localEulerAngles = var_14_8.localEulerAngles

				local var_14_11 = GameObjectTools.GetOrAddComponent(var_14_8.gameObject, typeof(DynamicBoneHelper))

				if var_14_11 then
					var_14_11:EnableDynamicBone(true)
				end
			end

			local var_14_12 = arg_11_1.actors_["1011ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1011ui_story = var_14_12.localPosition
			end

			local var_14_13 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_13 then
				var_14_12.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_11_1.time_ - 0) / var_14_13)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_13 and arg_11_1.time_ < 0 + var_14_13 + arg_14_0 then
				var_14_12.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_14_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_12.position).x, (manager.ui.mainCamera.transform.position - var_14_12.position).y, (manager.ui.mainCamera.transform.position - var_14_12.position).z)
				var_14_12.localEulerAngles.z = 0
				var_14_12.localEulerAngles.x = 0
				var_14_12.localEulerAngles = var_14_12.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_14_14 = 0
			local var_14_15 = 0.1

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_16 = arg_11_1:GetWordFromCfg(102081003)
				local var_14_17 = arg_11_1:FormatText(var_14_16.content)

				arg_11_1.text_.text = var_14_17

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_19 = 4 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 4)

				if (4 <= 0 and var_14_15 or var_14_15 * (utf8.len(var_14_17) / 4)) > 0 and var_14_15 < var_14_19 then
					arg_11_1.talkMaxDuration = var_14_19

					if var_14_19 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_14
					end
				end

				arg_11_1.text_.text = var_14_17
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081003", "story_v_out_102081.awb") ~= 0 then
					local var_14_20 = manager.audio:GetVoiceLength("story_v_out_102081", "102081003", "story_v_out_102081.awb") / 1000

					if var_14_20 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_14
					end

					if var_14_16.prefab_name ~= "" and arg_11_1.actors_[var_14_16.prefab_name] ~= nil then
						local var_14_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_16.prefab_name].transform, "story_v_out_102081", "102081003", "story_v_out_102081.awb")

						arg_11_1:RecordAudio("102081003", var_14_21)
						arg_11_1:RecordAudio("102081003", var_14_21)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_102081", "102081003", "story_v_out_102081.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_102081", "102081003", "story_v_out_102081.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_22 = math.max(var_14_15, arg_11_1.talkMaxDuration)

			if var_14_14 <= arg_11_1.time_ and arg_11_1.time_ < var_14_14 + var_14_22 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_14) / var_14_22

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_14 + var_14_22 and arg_11_1.time_ < var_14_14 + var_14_22 + arg_14_0 then
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
			if arg_15_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1084ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1084ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1084ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1084ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1084ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = var_18_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 and not isNil(var_18_3) then
				if arg_15_1.var_.characterEffect1084ui_story and not isNil(var_18_3) then
					arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1084ui_story then
				arg_15_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_18_6 = arg_15_1.actors_["1011ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect1011ui_story == nil then
				arg_15_1.var_.characterEffect1011ui_story = var_18_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_7 = 0.1

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_7 and not isNil(var_18_6) then
				if arg_15_1.var_.characterEffect1011ui_story and not isNil(var_18_6) then
					arg_15_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_7)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_7 and arg_15_1.time_ < 0 + var_18_7 + arg_18_0 and not isNil(var_18_6) and arg_15_1.var_.characterEffect1011ui_story then
				arg_15_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_18_8 = arg_15_1.actors_["1084ui_story"].transform

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = var_18_8.localPosition
			end

			local var_18_9 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_9 then
				var_18_8.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_15_1.time_ - 0) / var_18_9)
				var_18_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_8.position).x, (manager.ui.mainCamera.transform.position - var_18_8.position).y, (manager.ui.mainCamera.transform.position - var_18_8.position).z)
				var_18_8.localEulerAngles.z = 0
				var_18_8.localEulerAngles.x = 0
				var_18_8.localEulerAngles = var_18_8.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_9 and arg_15_1.time_ < 0 + var_18_9 + arg_18_0 then
				var_18_8.localPosition = Vector3.New(0.7, -0.97, -6)
				var_18_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_8.position).x, (manager.ui.mainCamera.transform.position - var_18_8.position).y, (manager.ui.mainCamera.transform.position - var_18_8.position).z)
				var_18_8.localEulerAngles.z = 0
				var_18_8.localEulerAngles.x = 0
				var_18_8.localEulerAngles = var_18_8.localEulerAngles
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_18_10 = 0
			local var_18_11 = 0.25

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_12 = arg_15_1:GetWordFromCfg(102081004)
				local var_18_13 = arg_15_1:FormatText(var_18_12.content)

				arg_15_1.text_.text = var_18_13

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_15 = 10 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 10)

				if (10 <= 0 and var_18_11 or var_18_11 * (utf8.len(var_18_13) / 10)) > 0 and var_18_11 < var_18_15 then
					arg_15_1.talkMaxDuration = var_18_15

					if var_18_15 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_15 + var_18_10
					end
				end

				arg_15_1.text_.text = var_18_13
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081004", "story_v_out_102081.awb") ~= 0 then
					local var_18_16 = manager.audio:GetVoiceLength("story_v_out_102081", "102081004", "story_v_out_102081.awb") / 1000

					if var_18_16 + var_18_10 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_16 + var_18_10
					end

					if var_18_12.prefab_name ~= "" and arg_15_1.actors_[var_18_12.prefab_name] ~= nil then
						local var_18_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_12.prefab_name].transform, "story_v_out_102081", "102081004", "story_v_out_102081.awb")

						arg_15_1:RecordAudio("102081004", var_18_17)
						arg_15_1:RecordAudio("102081004", var_18_17)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_102081", "102081004", "story_v_out_102081.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_102081", "102081004", "story_v_out_102081.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_18 = math.max(var_18_11, arg_15_1.talkMaxDuration)

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_18 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_10) / var_18_18

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_10 + var_18_18 and arg_15_1.time_ < var_18_10 + var_18_18 + arg_18_0 then
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
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = arg_19_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.1

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) then
				if arg_19_1.var_.characterEffect1084ui_story and not isNil(arg_19_1.actors_["1084ui_story"]) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_22_1 = arg_19_1.actors_["1084ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1084ui_story = var_22_1.localPosition
			end

			local var_22_2 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_2 then
				var_22_1.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_2)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_2 and arg_19_1.time_ < 0 + var_22_2 + arg_22_0 then
				var_22_1.localPosition = Vector3.New(0, 100, 0)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			local var_22_3 = arg_19_1.actors_["1011ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1011ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, 100, 0)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = "1019ui_story"

			if arg_19_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_22_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_19_1.stage_.transform)

				var_22_6.name = var_22_5
				var_22_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_[var_22_5] = var_22_6

				local var_22_7 = var_22_6:GetComponentInChildren(typeof(CharacterEffect))

				var_22_7.enabled = true

				local var_22_8 = GameObjectTools.GetOrAddComponent(var_22_6, typeof(DynamicBoneHelper))

				if var_22_8 then
					var_22_8:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_7.transform, false)

				arg_19_1.var_[var_22_5 .. "Animator"] = var_22_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_[var_22_5 .. "Animator"].applyRootMotion = true
				arg_19_1.var_[var_22_5 .. "LipSync"] = var_22_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_22_9 = 0
			local var_22_10 = 1

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_11 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(102081005).content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 40 <= 0 and var_22_10 or var_22_10 * (utf8.len(var_22_11) / 40)

				if (40 <= 0 and var_22_10 or var_22_10 * (utf8.len(var_22_11) / 40)) > 0 and var_22_10 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_9 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_9
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_10, arg_19_1.talkMaxDuration)

			if var_22_9 <= arg_19_1.time_ and arg_19_1.time_ < var_22_9 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_9) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_9 + var_22_14 and arg_19_1.time_ < var_22_9 + var_22_14 + arg_22_0 then
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
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) and arg_23_1.var_.characterEffect1019ui_story == nil then
				arg_23_1.var_.characterEffect1019ui_story = arg_23_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.1

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) then
				if arg_23_1.var_.characterEffect1019ui_story and not isNil(arg_23_1.actors_["1019ui_story"]) then
					arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1019ui_story"]) and arg_23_1.var_.characterEffect1019ui_story then
				arg_23_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_26_2 = arg_23_1.actors_["1019ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1019ui_story = var_26_2.localPosition
			end

			local var_26_3 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_3 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_23_1.time_ - 0) / var_26_3)
				var_26_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_2.position).x, (manager.ui.mainCamera.transform.position - var_26_2.position).y, (manager.ui.mainCamera.transform.position - var_26_2.position).z)
				var_26_2.localEulerAngles.z = 0
				var_26_2.localEulerAngles.x = 0
				var_26_2.localEulerAngles = var_26_2.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_3 and arg_23_1.time_ < 0 + var_26_3 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_26_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_2.position).x, (manager.ui.mainCamera.transform.position - var_26_2.position).y, (manager.ui.mainCamera.transform.position - var_26_2.position).z)
				var_26_2.localEulerAngles.z = 0
				var_26_2.localEulerAngles.x = 0
				var_26_2.localEulerAngles = var_26_2.localEulerAngles
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_26_4 = 0
			local var_26_5 = 0.525

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(102081006)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 21 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 21)

				if (21 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 21)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081006", "story_v_out_102081.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081006", "story_v_out_102081.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_102081", "102081006", "story_v_out_102081.awb")

						arg_23_1:RecordAudio("102081006", var_26_11)
						arg_23_1:RecordAudio("102081006", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_102081", "102081006", "story_v_out_102081.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_102081", "102081006", "story_v_out_102081.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
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
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1084ui_story"]) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = arg_27_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1084ui_story"]) then
				if arg_27_1.var_.characterEffect1084ui_story and not isNil(arg_27_1.actors_["1084ui_story"]) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1084ui_story"]) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_30_2 = arg_27_1.actors_["1019ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.characterEffect1019ui_story == nil then
				arg_27_1.var_.characterEffect1019ui_story = var_30_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_3 = 0.1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_3 and not isNil(var_30_2) then
				if arg_27_1.var_.characterEffect1019ui_story and not isNil(var_30_2) then
					arg_27_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_3)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_3 and arg_27_1.time_ < 0 + var_30_3 + arg_30_0 and not isNil(var_30_2) and arg_27_1.var_.characterEffect1019ui_story then
				arg_27_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_30_4 = arg_27_1.actors_["1084ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_4.localPosition
			end

			local var_30_5 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 then
				var_30_4.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_27_1.time_ - 0) / var_30_5)
				var_30_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_4.position).x, (manager.ui.mainCamera.transform.position - var_30_4.position).y, (manager.ui.mainCamera.transform.position - var_30_4.position).z)
				var_30_4.localEulerAngles.z = 0
				var_30_4.localEulerAngles.x = 0
				var_30_4.localEulerAngles = var_30_4.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 then
				var_30_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_30_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_4.position).x, (manager.ui.mainCamera.transform.position - var_30_4.position).y, (manager.ui.mainCamera.transform.position - var_30_4.position).z)
				var_30_4.localEulerAngles.z = 0
				var_30_4.localEulerAngles.x = 0
				var_30_4.localEulerAngles = var_30_4.localEulerAngles
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_6 = 0
			local var_30_7 = 0.175

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:GetWordFromCfg(102081007)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 7 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 7)

				if (7 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 7)) > 0 and var_30_7 < var_30_11 then
					arg_27_1.talkMaxDuration = var_30_11

					if var_30_11 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081007", "story_v_out_102081.awb") ~= 0 then
					local var_30_12 = manager.audio:GetVoiceLength("story_v_out_102081", "102081007", "story_v_out_102081.awb") / 1000

					if var_30_12 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_6
					end

					if var_30_8.prefab_name ~= "" and arg_27_1.actors_[var_30_8.prefab_name] ~= nil then
						local var_30_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_8.prefab_name].transform, "story_v_out_102081", "102081007", "story_v_out_102081.awb")

						arg_27_1:RecordAudio("102081007", var_30_13)
						arg_27_1:RecordAudio("102081007", var_30_13)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_102081", "102081007", "story_v_out_102081.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_102081", "102081007", "story_v_out_102081.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
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
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = arg_31_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.1

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) then
				if arg_31_1.var_.characterEffect1084ui_story and not isNil(arg_31_1.actors_["1084ui_story"]) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 0.975

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(102081008).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 39 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 39)

				if (39 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 39)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
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
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				local var_38_2 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_35_1.bgmTxt_.text ~= var_38_2 and arg_35_1.bgmTxt_.text ~= "" then
						if arg_35_1.bgmTxt2_.text ~= "" then
							arg_35_1.bgmTxt_.text = arg_35_1.bgmTxt2_.text
						end

						arg_35_1.bgmTxt2_.text = var_38_2

						arg_35_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_35_1.bgmTxt_.text = var_38_2
						arg_35_1.bgmTxt2_.text = var_38_2
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

			local var_38_3 = "10002ui_story"

			if arg_35_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_38_4 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_35_1.stage_.transform)

				var_38_4.name = var_38_3
				var_38_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_[var_38_3] = var_38_4

				local var_38_5 = var_38_4:GetComponentInChildren(typeof(CharacterEffect))

				var_38_5.enabled = true

				local var_38_6 = GameObjectTools.GetOrAddComponent(var_38_4, typeof(DynamicBoneHelper))

				if var_38_6 then
					var_38_6:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_5.transform, false)

				arg_35_1.var_[var_38_3 .. "Animator"] = var_38_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_[var_38_3 .. "Animator"].applyRootMotion = true
				arg_35_1.var_[var_38_3 .. "LipSync"] = var_38_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_7 = arg_35_1.actors_["10002ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.characterEffect10002ui_story == nil then
				arg_35_1.var_.characterEffect10002ui_story = var_38_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_8 = 0.1

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_8 and not isNil(var_38_7) then
				if arg_35_1.var_.characterEffect10002ui_story and not isNil(var_38_7) then
					arg_35_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_8 and arg_35_1.time_ < 0 + var_38_8 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.characterEffect10002ui_story then
				arg_35_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_38_10 = arg_35_1.actors_["1084ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = var_38_10.localPosition
			end

			local var_38_11 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_11 then
				var_38_10.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_11)
				var_38_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_10.position).x, (manager.ui.mainCamera.transform.position - var_38_10.position).y, (manager.ui.mainCamera.transform.position - var_38_10.position).z)
				var_38_10.localEulerAngles.z = 0
				var_38_10.localEulerAngles.x = 0
				var_38_10.localEulerAngles = var_38_10.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_11 and arg_35_1.time_ < 0 + var_38_11 + arg_38_0 then
				var_38_10.localPosition = Vector3.New(0, 100, 0)
				var_38_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_10.position).x, (manager.ui.mainCamera.transform.position - var_38_10.position).y, (manager.ui.mainCamera.transform.position - var_38_10.position).z)
				var_38_10.localEulerAngles.z = 0
				var_38_10.localEulerAngles.x = 0
				var_38_10.localEulerAngles = var_38_10.localEulerAngles
			end

			local var_38_12 = arg_35_1.actors_["1019ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1019ui_story = var_38_12.localPosition
			end

			local var_38_13 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_13 then
				var_38_12.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_13)
				var_38_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_12.position).x, (manager.ui.mainCamera.transform.position - var_38_12.position).y, (manager.ui.mainCamera.transform.position - var_38_12.position).z)
				var_38_12.localEulerAngles.z = 0
				var_38_12.localEulerAngles.x = 0
				var_38_12.localEulerAngles = var_38_12.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_13 and arg_35_1.time_ < 0 + var_38_13 + arg_38_0 then
				var_38_12.localPosition = Vector3.New(0, 100, 0)
				var_38_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_12.position).x, (manager.ui.mainCamera.transform.position - var_38_12.position).y, (manager.ui.mainCamera.transform.position - var_38_12.position).z)
				var_38_12.localEulerAngles.z = 0
				var_38_12.localEulerAngles.x = 0
				var_38_12.localEulerAngles = var_38_12.localEulerAngles
			end

			local var_38_14 = arg_35_1.actors_["10002ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10002ui_story = var_38_14.localPosition
			end

			local var_38_15 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_15 then
				var_38_14.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_35_1.time_ - 0) / var_38_15)
				var_38_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_14.position).x, (manager.ui.mainCamera.transform.position - var_38_14.position).y, (manager.ui.mainCamera.transform.position - var_38_14.position).z)
				var_38_14.localEulerAngles.z = 0
				var_38_14.localEulerAngles.x = 0
				var_38_14.localEulerAngles = var_38_14.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_15 and arg_35_1.time_ < 0 + var_38_15 + arg_38_0 then
				var_38_14.localPosition = Vector3.New(0, -1.2, -5.8)
				var_38_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_14.position).x, (manager.ui.mainCamera.transform.position - var_38_14.position).y, (manager.ui.mainCamera.transform.position - var_38_14.position).z)
				var_38_14.localEulerAngles.z = 0
				var_38_14.localEulerAngles.x = 0
				var_38_14.localEulerAngles = var_38_14.localEulerAngles
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_38_16 = 0
			local var_38_17 = 0.05

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(102081009)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_21 = 2 <= 0 and var_38_17 or var_38_17 * (utf8.len(var_38_19) / 2)

				if (2 <= 0 and var_38_17 or var_38_17 * (utf8.len(var_38_19) / 2)) > 0 and var_38_17 < var_38_21 then
					arg_35_1.talkMaxDuration = var_38_21

					if var_38_21 + var_38_16 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_21 + var_38_16
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081009", "story_v_out_102081.awb") ~= 0 then
					local var_38_22 = manager.audio:GetVoiceLength("story_v_out_102081", "102081009", "story_v_out_102081.awb") / 1000

					if var_38_22 + var_38_16 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_16
					end

					if var_38_18.prefab_name ~= "" and arg_35_1.actors_[var_38_18.prefab_name] ~= nil then
						local var_38_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_18.prefab_name].transform, "story_v_out_102081", "102081009", "story_v_out_102081.awb")

						arg_35_1:RecordAudio("102081009", var_38_23)
						arg_35_1:RecordAudio("102081009", var_38_23)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_102081", "102081009", "story_v_out_102081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_102081", "102081009", "story_v_out_102081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_24 = math.max(var_38_17, arg_35_1.talkMaxDuration)

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_24 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_16) / var_38_24

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_16 + var_38_24 and arg_35_1.time_ < var_38_16 + var_38_24 + arg_38_0 then
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
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = arg_40_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(arg_40_1.actors_["1084ui_story"]) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["10002ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect10002ui_story then
				arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_43_4 = arg_40_1.actors_["10002ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_4.localPosition
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_5)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, 100, 0)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			local var_43_6 = arg_40_1.actors_["1084ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_6.localPosition

				arg_40_1:ShowWeapon(arg_40_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_40_1.time_ - 0) / var_43_7)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, -0.97, -6)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_43_8 = 0
			local var_43_9 = 0.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(102081010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 7 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 7)

				if (7 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 7)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081010", "story_v_out_102081.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_102081", "102081010", "story_v_out_102081.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_102081", "102081010", "story_v_out_102081.awb")

						arg_40_1:RecordAudio("102081010", var_43_15)
						arg_40_1:RecordAudio("102081010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102081", "102081010", "story_v_out_102081.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102081", "102081010", "story_v_out_102081.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_16 and arg_40_1.time_ < var_43_8 + var_43_16 + arg_43_0 then
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
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = arg_44_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(arg_44_1.actors_["1019ui_story"]) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["1084ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, -0.97, -6)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			local var_47_6 = arg_44_1.actors_["1084ui_story"].transform

			if 0.033 < arg_44_1.time_ and arg_44_1.time_ <= 0.033 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_6.localPosition
			end

			local var_47_7 = 0.5

			if 0.033 <= arg_44_1.time_ and arg_44_1.time_ < 0.033 + var_47_7 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_44_1.time_ - 0.033) / var_47_7)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0.033 + var_47_7 and arg_44_1.time_ < 0.033 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_47_8 = arg_44_1.actors_["1019ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_8.localPosition
			end

			local var_47_9 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_9 then
				var_47_8.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_44_1.time_ - 0) / var_47_9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_9 and arg_44_1.time_ < 0 + var_47_9 + arg_47_0 then
				var_47_8.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_47_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_8.position).x, (manager.ui.mainCamera.transform.position - var_47_8.position).y, (manager.ui.mainCamera.transform.position - var_47_8.position).z)
				var_47_8.localEulerAngles.z = 0
				var_47_8.localEulerAngles.x = 0
				var_47_8.localEulerAngles = var_47_8.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_47_10 = 0
			local var_47_11 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_12 = arg_44_1:GetWordFromCfg(102081011)
				local var_47_13 = arg_44_1:FormatText(var_47_12.content)

				arg_44_1.text_.text = var_47_13

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 20 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 20)

				if (20 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 20)) > 0 and var_47_11 < var_47_15 then
					arg_44_1.talkMaxDuration = var_47_15

					if var_47_15 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_15 + var_47_10
					end
				end

				arg_44_1.text_.text = var_47_13
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081011", "story_v_out_102081.awb") ~= 0 then
					local var_47_16 = manager.audio:GetVoiceLength("story_v_out_102081", "102081011", "story_v_out_102081.awb") / 1000

					if var_47_16 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_16 + var_47_10
					end

					if var_47_12.prefab_name ~= "" and arg_44_1.actors_[var_47_12.prefab_name] ~= nil then
						local var_47_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_12.prefab_name].transform, "story_v_out_102081", "102081011", "story_v_out_102081.awb")

						arg_44_1:RecordAudio("102081011", var_47_17)
						arg_44_1:RecordAudio("102081011", var_47_17)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102081", "102081011", "story_v_out_102081.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102081", "102081011", "story_v_out_102081.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = math.max(var_47_11, arg_44_1.talkMaxDuration)

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_10) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_10 + var_47_18 and arg_44_1.time_ < var_47_10 + var_47_18 + arg_47_0 then
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
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story == nil then
				arg_48_1.var_.characterEffect10002ui_story = arg_48_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) then
				if arg_48_1.var_.characterEffect10002ui_story and not isNil(arg_48_1.actors_["10002ui_story"]) then
					arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10002ui_story"]) and arg_48_1.var_.characterEffect10002ui_story then
				arg_48_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1019ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["1084ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, 100, 0)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_51_6 = arg_48_1.actors_["10002ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos10002ui_story = var_51_6.localPosition
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_48_1.time_ - 0) / var_51_7)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_51_8 = 0
			local var_51_9 = 0.325

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_8 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_10 = arg_48_1:GetWordFromCfg(102081012)
				local var_51_11 = arg_48_1:FormatText(var_51_10.content)

				arg_48_1.text_.text = var_51_11

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_13 = 13 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 13)

				if (13 <= 0 and var_51_9 or var_51_9 * (utf8.len(var_51_11) / 13)) > 0 and var_51_9 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_8
					end
				end

				arg_48_1.text_.text = var_51_11
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081012", "story_v_out_102081.awb") ~= 0 then
					local var_51_14 = manager.audio:GetVoiceLength("story_v_out_102081", "102081012", "story_v_out_102081.awb") / 1000

					if var_51_14 + var_51_8 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_14 + var_51_8
					end

					if var_51_10.prefab_name ~= "" and arg_48_1.actors_[var_51_10.prefab_name] ~= nil then
						local var_51_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_10.prefab_name].transform, "story_v_out_102081", "102081012", "story_v_out_102081.awb")

						arg_48_1:RecordAudio("102081012", var_51_15)
						arg_48_1:RecordAudio("102081012", var_51_15)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102081", "102081012", "story_v_out_102081.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102081", "102081012", "story_v_out_102081.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = math.max(var_51_9, arg_48_1.talkMaxDuration)

			if var_51_8 <= arg_48_1.time_ and arg_48_1.time_ < var_51_8 + var_51_16 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_8) / var_51_16

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_8 + var_51_16 and arg_48_1.time_ < var_51_8 + var_51_16 + arg_51_0 then
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
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = arg_52_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) then
				if arg_52_1.var_.characterEffect1019ui_story and not isNil(arg_52_1.actors_["1019ui_story"]) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1019ui_story"]) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["10002ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_52_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_52_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.05

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(102081013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 2 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 2)

				if (2 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 2)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081013", "story_v_out_102081.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081013", "story_v_out_102081.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_102081", "102081013", "story_v_out_102081.awb")

						arg_52_1:RecordAudio("102081013", var_55_11)
						arg_52_1:RecordAudio("102081013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102081", "102081013", "story_v_out_102081.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102081", "102081013", "story_v_out_102081.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
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
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) and arg_56_1.var_.characterEffect10002ui_story == nil then
				arg_56_1.var_.characterEffect10002ui_story = arg_56_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) then
				if arg_56_1.var_.characterEffect10002ui_story and not isNil(arg_56_1.actors_["10002ui_story"]) then
					arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10002ui_story"]) and arg_56_1.var_.characterEffect10002ui_story then
				arg_56_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1019ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1019ui_story then
				arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.725

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(102081014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 29 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 29)

				if (29 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 29)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081014", "story_v_out_102081.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081014", "story_v_out_102081.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_102081", "102081014", "story_v_out_102081.awb")

						arg_56_1:RecordAudio("102081014", var_59_11)
						arg_56_1:RecordAudio("102081014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102081", "102081014", "story_v_out_102081.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102081", "102081014", "story_v_out_102081.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
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
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = arg_60_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) then
				if arg_60_1.var_.characterEffect1019ui_story and not isNil(arg_60_1.actors_["1019ui_story"]) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["10002ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect10002ui_story == nil then
				arg_60_1.var_.characterEffect10002ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect10002ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect10002ui_story then
				arg_60_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_63_4 = 0
			local var_63_5 = 0.5

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(102081015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 20 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 20)

				if (20 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 20)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081015", "story_v_out_102081.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081015", "story_v_out_102081.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_102081", "102081015", "story_v_out_102081.awb")

						arg_60_1:RecordAudio("102081015", var_63_11)
						arg_60_1:RecordAudio("102081015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102081", "102081015", "story_v_out_102081.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102081", "102081015", "story_v_out_102081.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
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
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) and arg_64_1.var_.characterEffect10002ui_story == nil then
				arg_64_1.var_.characterEffect10002ui_story = arg_64_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) then
				if arg_64_1.var_.characterEffect10002ui_story and not isNil(arg_64_1.actors_["10002ui_story"]) then
					arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["10002ui_story"]) and arg_64_1.var_.characterEffect10002ui_story then
				arg_64_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["1019ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_67_4 = 0
			local var_67_5 = 1.075

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(102081016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 43 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 43)

				if (43 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 43)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081016", "story_v_out_102081.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081016", "story_v_out_102081.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_102081", "102081016", "story_v_out_102081.awb")

						arg_64_1:RecordAudio("102081016", var_67_11)
						arg_64_1:RecordAudio("102081016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102081", "102081016", "story_v_out_102081.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102081", "102081016", "story_v_out_102081.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
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
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) and arg_68_1.var_.characterEffect1019ui_story == nil then
				arg_68_1.var_.characterEffect1019ui_story = arg_68_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) then
				if arg_68_1.var_.characterEffect1019ui_story and not isNil(arg_68_1.actors_["1019ui_story"]) then
					arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1019ui_story"]) and arg_68_1.var_.characterEffect1019ui_story then
				arg_68_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["10002ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10002ui_story == nil then
				arg_68_1.var_.characterEffect10002ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect10002ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10002ui_story then
				arg_68_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.725

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(102081017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 29 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 29)

				if (29 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 29)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081017", "story_v_out_102081.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081017", "story_v_out_102081.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_102081", "102081017", "story_v_out_102081.awb")

						arg_68_1:RecordAudio("102081017", var_71_11)
						arg_68_1:RecordAudio("102081017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102081", "102081017", "story_v_out_102081.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102081", "102081017", "story_v_out_102081.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
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
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_75_0 = 0
			local var_75_1 = 0.9

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(102081018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 36 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 36)

				if (36 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 36)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081018", "story_v_out_102081.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_102081", "102081018", "story_v_out_102081.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_102081", "102081018", "story_v_out_102081.awb")

						arg_72_1:RecordAudio("102081018", var_75_7)
						arg_72_1:RecordAudio("102081018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102081", "102081018", "story_v_out_102081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102081", "102081018", "story_v_out_102081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
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
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story == nil then
				arg_76_1.var_.characterEffect10002ui_story = arg_76_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) then
				if arg_76_1.var_.characterEffect10002ui_story and not isNil(arg_76_1.actors_["10002ui_story"]) then
					arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["10002ui_story"]) and arg_76_1.var_.characterEffect10002ui_story then
				arg_76_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1019ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(102081019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 15 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 15)

				if (15 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 15)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081019", "story_v_out_102081.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081019", "story_v_out_102081.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_102081", "102081019", "story_v_out_102081.awb")

						arg_76_1:RecordAudio("102081019", var_79_11)
						arg_76_1:RecordAudio("102081019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_102081", "102081019", "story_v_out_102081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_102081", "102081019", "story_v_out_102081.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
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
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1019ui_story = arg_80_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).z)
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles = arg_80_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1019ui_story"].transform.position).z)
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1019ui_story"].transform.localEulerAngles = arg_80_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["10002ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, Vector3.New(0.7, -1.2, -5.8), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0.7, -1.2, -5.8)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = arg_80_1.actors_["10002ui_story"].transform

			if 0.033 < arg_80_1.time_ and arg_80_1.time_ <= 0.033 + arg_83_0 then
				arg_80_1.var_.moveOldPos10002ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.5

			if 0.033 <= arg_80_1.time_ and arg_80_1.time_ < 0.033 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_80_1.time_ - 0.033) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0.033 + var_83_4 and arg_80_1.time_ < 0.033 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, -1.2, -5.8)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_83_5 = 0
			local var_83_6 = 0.275

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(102081020)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 11 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 11)

				if (11 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 11)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081020", "story_v_out_102081.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_102081", "102081020", "story_v_out_102081.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_102081", "102081020", "story_v_out_102081.awb")

						arg_80_1:RecordAudio("102081020", var_83_12)
						arg_80_1:RecordAudio("102081020", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102081", "102081020", "story_v_out_102081.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102081", "102081020", "story_v_out_102081.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
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
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10002ui_story"]) and arg_84_1.var_.characterEffect10002ui_story == nil then
				arg_84_1.var_.characterEffect10002ui_story = arg_84_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10002ui_story"]) then
				if arg_84_1.var_.characterEffect10002ui_story and not isNil(arg_84_1.actors_["10002ui_story"]) then
					arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10002ui_story"]) and arg_84_1.var_.characterEffect10002ui_story then
				arg_84_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.625

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(102081021).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 25 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 25)

				if (25 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 25)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
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
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10002ui_story"]) and arg_88_1.var_.characterEffect10002ui_story == nil then
				arg_88_1.var_.characterEffect10002ui_story = arg_88_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10002ui_story"]) then
				if arg_88_1.var_.characterEffect10002ui_story and not isNil(arg_88_1.actors_["10002ui_story"]) then
					arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10002ui_story"]) and arg_88_1.var_.characterEffect10002ui_story then
				arg_88_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_91_2 = 0
			local var_91_3 = 0.775

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(102081022)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 31 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 31)

				if (31 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 31)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081022", "story_v_out_102081.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_102081", "102081022", "story_v_out_102081.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_102081", "102081022", "story_v_out_102081.awb")

						arg_88_1:RecordAudio("102081022", var_91_9)
						arg_88_1:RecordAudio("102081022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102081", "102081022", "story_v_out_102081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102081", "102081022", "story_v_out_102081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
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
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10002ui_story"]) and arg_92_1.var_.characterEffect10002ui_story == nil then
				arg_92_1.var_.characterEffect10002ui_story = arg_92_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10002ui_story"]) then
				if arg_92_1.var_.characterEffect10002ui_story and not isNil(arg_92_1.actors_["10002ui_story"]) then
					arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10002ui_story"]) and arg_92_1.var_.characterEffect10002ui_story then
				arg_92_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_95_1 = arg_92_1.actors_["10002ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_1.localPosition
			end

			local var_95_2 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_2 then
				var_95_1.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_2)
				var_95_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_1.position).x, (manager.ui.mainCamera.transform.position - var_95_1.position).y, (manager.ui.mainCamera.transform.position - var_95_1.position).z)
				var_95_1.localEulerAngles.z = 0
				var_95_1.localEulerAngles.x = 0
				var_95_1.localEulerAngles = var_95_1.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_2 and arg_92_1.time_ < 0 + var_95_2 + arg_95_0 then
				var_95_1.localPosition = Vector3.New(0, 100, 0)
				var_95_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_1.position).x, (manager.ui.mainCamera.transform.position - var_95_1.position).y, (manager.ui.mainCamera.transform.position - var_95_1.position).z)
				var_95_1.localEulerAngles.z = 0
				var_95_1.localEulerAngles.x = 0
				var_95_1.localEulerAngles = var_95_1.localEulerAngles
			end

			local var_95_3 = 0
			local var_95_4 = 0.625

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_3 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(102081023).content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 25 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_5) / 25)

				if (25 <= 0 and var_95_4 or var_95_4 * (utf8.len(var_95_5) / 25)) > 0 and var_95_4 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_3 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_3
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_4, arg_92_1.talkMaxDuration)

			if var_95_3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_3 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_3) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_3 + var_95_8 and arg_92_1.time_ < var_95_3 + var_95_8 + arg_95_0 then
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
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) and arg_96_1.var_.characterEffect10002ui_story == nil then
				arg_96_1.var_.characterEffect10002ui_story = arg_96_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) then
				if arg_96_1.var_.characterEffect10002ui_story and not isNil(arg_96_1.actors_["10002ui_story"]) then
					arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10002ui_story"]) and arg_96_1.var_.characterEffect10002ui_story then
				arg_96_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["10002ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10002ui_story = var_99_2.localPosition
			end

			local var_99_3 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 then
				var_99_2.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_96_1.time_ - 0) / var_99_3)
				var_99_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_2.position).x, (manager.ui.mainCamera.transform.position - var_99_2.position).y, (manager.ui.mainCamera.transform.position - var_99_2.position).z)
				var_99_2.localEulerAngles.z = 0
				var_99_2.localEulerAngles.x = 0
				var_99_2.localEulerAngles = var_99_2.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 then
				var_99_2.localPosition = Vector3.New(0, -1.2, -5.8)
				var_99_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_2.position).x, (manager.ui.mainCamera.transform.position - var_99_2.position).y, (manager.ui.mainCamera.transform.position - var_99_2.position).z)
				var_99_2.localEulerAngles.z = 0
				var_99_2.localEulerAngles.x = 0
				var_99_2.localEulerAngles = var_99_2.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_4 = 0
			local var_99_5 = 1

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(102081024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 40 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 40)

				if (40 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 40)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081024", "story_v_out_102081.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081024", "story_v_out_102081.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_102081", "102081024", "story_v_out_102081.awb")

						arg_96_1:RecordAudio("102081024", var_99_11)
						arg_96_1:RecordAudio("102081024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102081", "102081024", "story_v_out_102081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102081", "102081024", "story_v_out_102081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
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
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = arg_100_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) then
				if arg_100_1.var_.characterEffect1019ui_story and not isNil(arg_100_1.actors_["1019ui_story"]) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["10002ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect10002ui_story == nil then
				arg_100_1.var_.characterEffect10002ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect10002ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect10002ui_story then
				arg_100_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_103_4 = arg_100_1.actors_["10002ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10002ui_story = var_103_4.localPosition
			end

			local var_103_5 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				var_103_4.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_5)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 then
				var_103_4.localPosition = Vector3.New(0, 100, 0)
				var_103_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_4.position).x, (manager.ui.mainCamera.transform.position - var_103_4.position).y, (manager.ui.mainCamera.transform.position - var_103_4.position).z)
				var_103_4.localEulerAngles.z = 0
				var_103_4.localEulerAngles.x = 0
				var_103_4.localEulerAngles = var_103_4.localEulerAngles
			end

			local var_103_6 = arg_100_1.actors_["1019ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1019ui_story = var_103_6.localPosition
			end

			local var_103_7 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				var_103_6.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_100_1.time_ - 0) / var_103_7)
				var_103_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_6.position).x, (manager.ui.mainCamera.transform.position - var_103_6.position).y, (manager.ui.mainCamera.transform.position - var_103_6.position).z)
				var_103_6.localEulerAngles.z = 0
				var_103_6.localEulerAngles.x = 0
				var_103_6.localEulerAngles = var_103_6.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				var_103_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_103_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_6.position).x, (manager.ui.mainCamera.transform.position - var_103_6.position).y, (manager.ui.mainCamera.transform.position - var_103_6.position).z)
				var_103_6.localEulerAngles.z = 0
				var_103_6.localEulerAngles.x = 0
				var_103_6.localEulerAngles = var_103_6.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_103_8 = 0
			local var_103_9 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_10 = arg_100_1:GetWordFromCfg(102081025)
				local var_103_11 = arg_100_1:FormatText(var_103_10.content)

				arg_100_1.text_.text = var_103_11

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 17 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 17)

				if (17 <= 0 and var_103_9 or var_103_9 * (utf8.len(var_103_11) / 17)) > 0 and var_103_9 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_11
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081025", "story_v_out_102081.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_102081", "102081025", "story_v_out_102081.awb") / 1000

					if var_103_14 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_8
					end

					if var_103_10.prefab_name ~= "" and arg_100_1.actors_[var_103_10.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_10.prefab_name].transform, "story_v_out_102081", "102081025", "story_v_out_102081.awb")

						arg_100_1:RecordAudio("102081025", var_103_15)
						arg_100_1:RecordAudio("102081025", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102081", "102081025", "story_v_out_102081.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102081", "102081025", "story_v_out_102081.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
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
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10002ui_story"]) and arg_104_1.var_.characterEffect10002ui_story == nil then
				arg_104_1.var_.characterEffect10002ui_story = arg_104_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10002ui_story"]) then
				if arg_104_1.var_.characterEffect10002ui_story and not isNil(arg_104_1.actors_["10002ui_story"]) then
					arg_104_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10002ui_story"]) and arg_104_1.var_.characterEffect10002ui_story then
				arg_104_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1019ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1019ui_story = var_107_2.localPosition
			end

			local var_107_3 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 then
				var_107_2.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_3)
				var_107_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_2.position).x, (manager.ui.mainCamera.transform.position - var_107_2.position).y, (manager.ui.mainCamera.transform.position - var_107_2.position).z)
				var_107_2.localEulerAngles.z = 0
				var_107_2.localEulerAngles.x = 0
				var_107_2.localEulerAngles = var_107_2.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 then
				var_107_2.localPosition = Vector3.New(0, 100, 0)
				var_107_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_2.position).x, (manager.ui.mainCamera.transform.position - var_107_2.position).y, (manager.ui.mainCamera.transform.position - var_107_2.position).z)
				var_107_2.localEulerAngles.z = 0
				var_107_2.localEulerAngles.x = 0
				var_107_2.localEulerAngles = var_107_2.localEulerAngles
			end

			local var_107_4 = arg_104_1.actors_["10002ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10002ui_story = var_107_4.localPosition
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_4.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_104_1.time_ - 0) / var_107_5)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_4.localPosition = Vector3.New(0, -1.2, -5.8)
				var_107_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_4.position).x, (manager.ui.mainCamera.transform.position - var_107_4.position).y, (manager.ui.mainCamera.transform.position - var_107_4.position).z)
				var_107_4.localEulerAngles.z = 0
				var_107_4.localEulerAngles.x = 0
				var_107_4.localEulerAngles = var_107_4.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_107_6 = 0
			local var_107_7 = 0.05

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(102081026)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 2 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 2)

				if (2 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 2)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081026", "story_v_out_102081.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_102081", "102081026", "story_v_out_102081.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_102081", "102081026", "story_v_out_102081.awb")

						arg_104_1:RecordAudio("102081026", var_107_13)
						arg_104_1:RecordAudio("102081026", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102081", "102081026", "story_v_out_102081.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102081", "102081026", "story_v_out_102081.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
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
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1011ui_story"]) and arg_108_1.var_.characterEffect1011ui_story == nil then
				arg_108_1.var_.characterEffect1011ui_story = arg_108_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1011ui_story"]) then
				if arg_108_1.var_.characterEffect1011ui_story and not isNil(arg_108_1.actors_["1011ui_story"]) then
					arg_108_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1011ui_story"]) and arg_108_1.var_.characterEffect1011ui_story then
				arg_108_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["10002ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect10002ui_story == nil then
				arg_108_1.var_.characterEffect10002ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect10002ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect10002ui_story then
				arg_108_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_111_4 = arg_108_1.actors_["10002ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10002ui_story = var_111_4.localPosition
			end

			local var_111_5 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 then
				var_111_4.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_5)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 then
				var_111_4.localPosition = Vector3.New(0, 100, 0)
				var_111_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_4.position).x, (manager.ui.mainCamera.transform.position - var_111_4.position).y, (manager.ui.mainCamera.transform.position - var_111_4.position).z)
				var_111_4.localEulerAngles.z = 0
				var_111_4.localEulerAngles.x = 0
				var_111_4.localEulerAngles = var_111_4.localEulerAngles
			end

			local var_111_6 = arg_108_1.actors_["1011ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1011ui_story = var_111_6.localPosition
			end

			local var_111_7 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				var_111_6.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_108_1.time_ - 0) / var_111_7)
				var_111_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_6.position).x, (manager.ui.mainCamera.transform.position - var_111_6.position).y, (manager.ui.mainCamera.transform.position - var_111_6.position).z)
				var_111_6.localEulerAngles.z = 0
				var_111_6.localEulerAngles.x = 0
				var_111_6.localEulerAngles = var_111_6.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				var_111_6.localPosition = Vector3.New(0, -0.71, -6)
				var_111_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_6.position).x, (manager.ui.mainCamera.transform.position - var_111_6.position).y, (manager.ui.mainCamera.transform.position - var_111_6.position).z)
				var_111_6.localEulerAngles.z = 0
				var_111_6.localEulerAngles.x = 0
				var_111_6.localEulerAngles = var_111_6.localEulerAngles
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_111_8 = 0
			local var_111_9 = 0.4

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_10 = arg_108_1:GetWordFromCfg(102081027)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 16 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 16)

				if (16 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 16)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081027", "story_v_out_102081.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_102081", "102081027", "story_v_out_102081.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_102081", "102081027", "story_v_out_102081.awb")

						arg_108_1:RecordAudio("102081027", var_111_15)
						arg_108_1:RecordAudio("102081027", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102081", "102081027", "story_v_out_102081.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102081", "102081027", "story_v_out_102081.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
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
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_115_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_112_1.bgmTxt_.text ~= var_115_2 and arg_112_1.bgmTxt_.text ~= "" then
						if arg_112_1.bgmTxt2_.text ~= "" then
							arg_112_1.bgmTxt_.text = arg_112_1.bgmTxt2_.text
						end

						arg_112_1.bgmTxt2_.text = var_115_2

						arg_112_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_112_1.bgmTxt_.text = var_115_2
						arg_112_1.bgmTxt2_.text = var_115_2
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

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_115_4 = arg_112_1.actors_["1011ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1011ui_story == nil then
				arg_112_1.var_.characterEffect1011ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_5 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_5 and not isNil(var_115_4) then
				if arg_112_1.var_.characterEffect1011ui_story and not isNil(var_115_4) then
					arg_112_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_5)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_5 and arg_112_1.time_ < 0 + var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1011ui_story then
				arg_112_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_115_6 = arg_112_1.actors_["1011ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1011ui_story = var_115_6.localPosition
			end

			local var_115_7 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				var_115_6.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_7)
				var_115_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_6.position).x, (manager.ui.mainCamera.transform.position - var_115_6.position).y, (manager.ui.mainCamera.transform.position - var_115_6.position).z)
				var_115_6.localEulerAngles.z = 0
				var_115_6.localEulerAngles.x = 0
				var_115_6.localEulerAngles = var_115_6.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				var_115_6.localPosition = Vector3.New(0, 100, 0)
				var_115_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_6.position).x, (manager.ui.mainCamera.transform.position - var_115_6.position).y, (manager.ui.mainCamera.transform.position - var_115_6.position).z)
				var_115_6.localEulerAngles.z = 0
				var_115_6.localEulerAngles.x = 0
				var_115_6.localEulerAngles = var_115_6.localEulerAngles
			end

			local var_115_8 = 0
			local var_115_9 = 0.375

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[29].name)

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

				local var_115_10 = arg_112_1:GetWordFromCfg(102081028)
				local var_115_11 = arg_112_1:FormatText(var_115_10.content)

				arg_112_1.text_.text = var_115_11

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 15 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 15)

				if (15 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_11) / 15)) > 0 and var_115_9 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_11
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081028", "story_v_out_102081.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_102081", "102081028", "story_v_out_102081.awb") / 1000

					if var_115_14 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_8
					end

					if var_115_10.prefab_name ~= "" and arg_112_1.actors_[var_115_10.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_10.prefab_name].transform, "story_v_out_102081", "102081028", "story_v_out_102081.awb")

						arg_112_1:RecordAudio("102081028", var_115_15)
						arg_112_1:RecordAudio("102081028", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102081", "102081028", "story_v_out_102081.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102081", "102081028", "story_v_out_102081.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_16 and arg_112_1.time_ < var_115_8 + var_115_16 + arg_115_0 then
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
			local var_120_0 = 0.525

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(102081029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 21 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 21)

				if (21 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 21)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
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
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10002ui_story"]) and arg_121_1.var_.characterEffect10002ui_story == nil then
				arg_121_1.var_.characterEffect10002ui_story = arg_121_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.1

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10002ui_story"]) then
				if arg_121_1.var_.characterEffect10002ui_story and not isNil(arg_121_1.actors_["10002ui_story"]) then
					arg_121_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10002ui_story"]) and arg_121_1.var_.characterEffect10002ui_story then
				arg_121_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			local var_124_2 = arg_121_1.actors_["10002ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10002ui_story = var_124_2.localPosition
			end

			local var_124_3 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_121_1.time_ - 0) / var_124_3)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(0, -1.2, -5.8)
				var_124_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_2.position).x, (manager.ui.mainCamera.transform.position - var_124_2.position).y, (manager.ui.mainCamera.transform.position - var_124_2.position).z)
				var_124_2.localEulerAngles.z = 0
				var_124_2.localEulerAngles.x = 0
				var_124_2.localEulerAngles = var_124_2.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.375

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(102081030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 15 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 15)

				if (15 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 15)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081030", "story_v_out_102081.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081030", "story_v_out_102081.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_102081", "102081030", "story_v_out_102081.awb")

						arg_121_1:RecordAudio("102081030", var_124_11)
						arg_121_1:RecordAudio("102081030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_102081", "102081030", "story_v_out_102081.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_102081", "102081030", "story_v_out_102081.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
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
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10002ui_story"]) and arg_125_1.var_.characterEffect10002ui_story == nil then
				arg_125_1.var_.characterEffect10002ui_story = arg_125_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.1

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10002ui_story"]) then
				if arg_125_1.var_.characterEffect10002ui_story and not isNil(arg_125_1.actors_["10002ui_story"]) then
					arg_125_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10002ui_story"]) and arg_125_1.var_.characterEffect10002ui_story then
				arg_125_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_128_1 = arg_125_1.actors_["10002ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10002ui_story = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10002ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_2)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, 100, 0)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			local var_128_3 = 0
			local var_128_4 = 1.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_5 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(102081031).content)

				arg_125_1.text_.text = var_128_5

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_7 = 47 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_5) / 47)

				if (47 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_5) / 47)) > 0 and var_128_4 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_3
					end
				end

				arg_125_1.text_.text = var_128_5
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_4, arg_125_1.talkMaxDuration)

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_3) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_3 + var_128_8 and arg_125_1.time_ < var_128_3 + var_128_8 + arg_128_0 then
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
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = arg_129_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(arg_129_1.actors_["1084ui_story"]) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["1084ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1084ui_story = var_132_2.localPosition

				arg_129_1:ShowWeapon(arg_129_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_132_3 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_129_1.time_ - 0) / var_132_3)
				var_132_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_2.position).x, (manager.ui.mainCamera.transform.position - var_132_2.position).y, (manager.ui.mainCamera.transform.position - var_132_2.position).z)
				var_132_2.localEulerAngles.z = 0
				var_132_2.localEulerAngles.x = 0
				var_132_2.localEulerAngles = var_132_2.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -0.97, -6)
				var_132_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_2.position).x, (manager.ui.mainCamera.transform.position - var_132_2.position).y, (manager.ui.mainCamera.transform.position - var_132_2.position).z)
				var_132_2.localEulerAngles.z = 0
				var_132_2.localEulerAngles.x = 0
				var_132_2.localEulerAngles = var_132_2.localEulerAngles
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_132_4 = 0
			local var_132_5 = 0.3

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(102081032)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 12 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 12)

				if (12 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 12)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081032", "story_v_out_102081.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_102081", "102081032", "story_v_out_102081.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_102081", "102081032", "story_v_out_102081.awb")

						arg_129_1:RecordAudio("102081032", var_132_11)
						arg_129_1:RecordAudio("102081032", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_102081", "102081032", "story_v_out_102081.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_102081", "102081032", "story_v_out_102081.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:AudioAction("play", "effect", "se_story", "se_story_robot_long", "")
			end

			local var_136_1 = arg_133_1.actors_["2022_tpose"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect2022_tpose == nil then
				arg_133_1.var_.characterEffect2022_tpose = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect2022_tpose and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect2022_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect2022_tpose then
				arg_133_1.var_.characterEffect2022_tpose.fillFlat = false
			end

			local var_136_4 = "2021_tpose"

			if arg_133_1.actors_["2021_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2021_tpose"))) then
				local var_136_5 = Object.Instantiate(Asset.Load("Char/" .. "2021_tpose"), arg_133_1.stage_.transform)

				var_136_5.name = var_136_4
				var_136_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_[var_136_4] = var_136_5

				local var_136_6 = var_136_5:GetComponentInChildren(typeof(CharacterEffect))

				var_136_6.enabled = true

				local var_136_7 = GameObjectTools.GetOrAddComponent(var_136_5, typeof(DynamicBoneHelper))

				if var_136_7 then
					var_136_7:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_6.transform, false)

				arg_133_1.var_[var_136_4 .. "Animator"] = var_136_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_[var_136_4 .. "Animator"].applyRootMotion = true
				arg_133_1.var_[var_136_4 .. "LipSync"] = var_136_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_8 = arg_133_1.actors_["2021_tpose"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect2021_tpose == nil then
				arg_133_1.var_.characterEffect2021_tpose = var_136_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_9 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_9 and not isNil(var_136_8) then
				if arg_133_1.var_.characterEffect2021_tpose and not isNil(var_136_8) then
					arg_133_1.var_.characterEffect2021_tpose.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_9 and arg_133_1.time_ < 0 + var_136_9 + arg_136_0 and not isNil(var_136_8) and arg_133_1.var_.characterEffect2021_tpose then
				arg_133_1.var_.characterEffect2021_tpose.fillFlat = false
			end

			local var_136_11 = arg_133_1.actors_["1084ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_12 = 0.1

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_12 and not isNil(var_136_11) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_11) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_12)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_12 and arg_133_1.time_ < 0 + var_136_12 + arg_136_0 and not isNil(var_136_11) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_136_13 = arg_133_1.actors_["1084ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_13.localPosition
			end

			local var_136_14 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_14 then
				var_136_13.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_14)
				var_136_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_13.position).x, (manager.ui.mainCamera.transform.position - var_136_13.position).y, (manager.ui.mainCamera.transform.position - var_136_13.position).z)
				var_136_13.localEulerAngles.z = 0
				var_136_13.localEulerAngles.x = 0
				var_136_13.localEulerAngles = var_136_13.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_14 and arg_133_1.time_ < 0 + var_136_14 + arg_136_0 then
				var_136_13.localPosition = Vector3.New(0, 100, 0)
				var_136_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_13.position).x, (manager.ui.mainCamera.transform.position - var_136_13.position).y, (manager.ui.mainCamera.transform.position - var_136_13.position).z)
				var_136_13.localEulerAngles.z = 0
				var_136_13.localEulerAngles.x = 0
				var_136_13.localEulerAngles = var_136_13.localEulerAngles
			end

			local var_136_15 = arg_133_1.actors_["2021_tpose"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos2021_tpose = var_136_15.localPosition

				local var_136_16 = GameObjectTools.GetOrAddComponent(var_136_15.gameObject, typeof(DynamicBoneHelper))

				if var_136_16 then
					var_136_16:EnableDynamicBone(false)
				end
			end

			local var_136_17 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_17 then
				var_136_15.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos2021_tpose, Vector3.New(-1.92, -0.6, 0.2), (arg_133_1.time_ - 0) / var_136_17)
				var_136_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_15.position).x, (manager.ui.mainCamera.transform.position - var_136_15.position).y, (manager.ui.mainCamera.transform.position - var_136_15.position).z)
				var_136_15.localEulerAngles.z = 0
				var_136_15.localEulerAngles.x = 0
				var_136_15.localEulerAngles = var_136_15.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_17 and arg_133_1.time_ < 0 + var_136_17 + arg_136_0 then
				var_136_15.localPosition = Vector3.New(-1.92, -0.6, 0.2)
				var_136_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_15.position).x, (manager.ui.mainCamera.transform.position - var_136_15.position).y, (manager.ui.mainCamera.transform.position - var_136_15.position).z)
				var_136_15.localEulerAngles.z = 0
				var_136_15.localEulerAngles.x = 0
				var_136_15.localEulerAngles = var_136_15.localEulerAngles

				local var_136_18 = GameObjectTools.GetOrAddComponent(var_136_15.gameObject, typeof(DynamicBoneHelper))

				if var_136_18 then
					var_136_18:EnableDynamicBone(true)
				end
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("2021_tpose", "StoryTimeline/CharAction/story2021/story2021action/2021action1_1")
			end

			local var_136_19 = arg_133_1.actors_["2022_tpose"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos2022_tpose = var_136_19.localPosition

				local var_136_20 = GameObjectTools.GetOrAddComponent(var_136_19.gameObject, typeof(DynamicBoneHelper))

				if var_136_20 then
					var_136_20:EnableDynamicBone(false)
				end
			end

			local var_136_21 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_21 then
				var_136_19.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos2022_tpose, Vector3.New(0.7, -0.55, -0.3), (arg_133_1.time_ - 0) / var_136_21)
				var_136_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_19.position).x, (manager.ui.mainCamera.transform.position - var_136_19.position).y, (manager.ui.mainCamera.transform.position - var_136_19.position).z)
				var_136_19.localEulerAngles.z = 0
				var_136_19.localEulerAngles.x = 0
				var_136_19.localEulerAngles = var_136_19.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_21 and arg_133_1.time_ < 0 + var_136_21 + arg_136_0 then
				var_136_19.localPosition = Vector3.New(0.7, -0.55, -0.3)
				var_136_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_19.position).x, (manager.ui.mainCamera.transform.position - var_136_19.position).y, (manager.ui.mainCamera.transform.position - var_136_19.position).z)
				var_136_19.localEulerAngles.z = 0
				var_136_19.localEulerAngles.x = 0
				var_136_19.localEulerAngles = var_136_19.localEulerAngles

				local var_136_22 = GameObjectTools.GetOrAddComponent(var_136_19.gameObject, typeof(DynamicBoneHelper))

				if var_136_22 then
					var_136_22:EnableDynamicBone(true)
				end
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("2022_tpose", "StoryTimeline/CharAction/story2022/story2022action/2022action1_1")
			end

			local var_136_23 = 0
			local var_136_24 = 0.45

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_25 = arg_133_1:GetWordFromCfg(102081033)
				local var_136_26 = arg_133_1:FormatText(var_136_25.content)

				arg_133_1.text_.text = var_136_26

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 18 <= 0 and var_136_24 or var_136_24 * (utf8.len(var_136_26) / 18)

				if (18 <= 0 and var_136_24 or var_136_24 * (utf8.len(var_136_26) / 18)) > 0 and var_136_24 < var_136_28 then
					arg_133_1.talkMaxDuration = var_136_28

					if var_136_28 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_28 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_26
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081033", "story_v_out_102081.awb") ~= 0 then
					local var_136_29 = manager.audio:GetVoiceLength("story_v_out_102081", "102081033", "story_v_out_102081.awb") / 1000

					if var_136_29 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_29 + var_136_23
					end

					if var_136_25.prefab_name ~= "" and arg_133_1.actors_[var_136_25.prefab_name] ~= nil then
						local var_136_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_25.prefab_name].transform, "story_v_out_102081", "102081033", "story_v_out_102081.awb")

						arg_133_1:RecordAudio("102081033", var_136_30)
						arg_133_1:RecordAudio("102081033", var_136_30)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_102081", "102081033", "story_v_out_102081.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_102081", "102081033", "story_v_out_102081.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_31 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_31 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_31

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_31 and arg_133_1.time_ < var_136_23 + var_136_31 + arg_136_0 then
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
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1019ui_story"]) and arg_137_1.var_.characterEffect1019ui_story == nil then
				arg_137_1.var_.characterEffect1019ui_story = arg_137_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1019ui_story"]) then
				if arg_137_1.var_.characterEffect1019ui_story and not isNil(arg_137_1.actors_["1019ui_story"]) then
					arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1019ui_story"]) and arg_137_1.var_.characterEffect1019ui_story then
				arg_137_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["2022_tpose"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect2022_tpose == nil then
				arg_137_1.var_.characterEffect2022_tpose = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect2022_tpose and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect2022_tpose.fillFlat = true
					arg_137_1.var_.characterEffect2022_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect2022_tpose then
				arg_137_1.var_.characterEffect2022_tpose.fillFlat = true
				arg_137_1.var_.characterEffect2022_tpose.fillRatio = 0.5
			end

			local var_140_4 = arg_137_1.actors_["2021_tpose"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect2021_tpose == nil then
				arg_137_1.var_.characterEffect2021_tpose = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.1

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect2021_tpose and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect2021_tpose.fillFlat = true
					arg_137_1.var_.characterEffect2021_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect2021_tpose then
				arg_137_1.var_.characterEffect2021_tpose.fillFlat = true
				arg_137_1.var_.characterEffect2021_tpose.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_140_6 = 0
			local var_140_7 = 0.45

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[13].name)

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

				local var_140_8 = arg_137_1:GetWordFromCfg(102081034)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 18 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 18)

				if (18 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 18)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081034", "story_v_out_102081.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_102081", "102081034", "story_v_out_102081.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_102081", "102081034", "story_v_out_102081.awb")

						arg_137_1:RecordAudio("102081034", var_140_13)
						arg_137_1:RecordAudio("102081034", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_102081", "102081034", "story_v_out_102081.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_102081", "102081034", "story_v_out_102081.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
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
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10002ui_story"]) and arg_141_1.var_.characterEffect10002ui_story == nil then
				arg_141_1.var_.characterEffect10002ui_story = arg_141_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.1

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10002ui_story"]) then
				if arg_141_1.var_.characterEffect10002ui_story and not isNil(arg_141_1.actors_["10002ui_story"]) then
					arg_141_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10002ui_story"]) and arg_141_1.var_.characterEffect10002ui_story then
				arg_141_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["2021_tpose"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos2021_tpose = var_144_2.localPosition

				local var_144_3 = GameObjectTools.GetOrAddComponent(var_144_2.gameObject, typeof(DynamicBoneHelper))

				if var_144_3 then
					var_144_3:EnableDynamicBone(false)
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2021_tpose, Vector3.New(10, -0.6, 0.2), (arg_141_1.time_ - 0) / var_144_4)
				var_144_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_2.position).x, (manager.ui.mainCamera.transform.position - var_144_2.position).y, (manager.ui.mainCamera.transform.position - var_144_2.position).z)
				var_144_2.localEulerAngles.z = 0
				var_144_2.localEulerAngles.x = 0
				var_144_2.localEulerAngles = var_144_2.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(10, -0.6, 0.2)
				var_144_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_2.position).x, (manager.ui.mainCamera.transform.position - var_144_2.position).y, (manager.ui.mainCamera.transform.position - var_144_2.position).z)
				var_144_2.localEulerAngles.z = 0
				var_144_2.localEulerAngles.x = 0
				var_144_2.localEulerAngles = var_144_2.localEulerAngles

				local var_144_5 = GameObjectTools.GetOrAddComponent(var_144_2.gameObject, typeof(DynamicBoneHelper))

				if var_144_5 then
					var_144_5:EnableDynamicBone(true)
				end
			end

			local var_144_6 = arg_141_1.actors_["2022_tpose"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos2022_tpose = var_144_6.localPosition

				local var_144_7 = GameObjectTools.GetOrAddComponent(var_144_6.gameObject, typeof(DynamicBoneHelper))

				if var_144_7 then
					var_144_7:EnableDynamicBone(false)
				end
			end

			local var_144_8 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_8 then
				var_144_6.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2022_tpose, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_8)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_8 and arg_141_1.time_ < 0 + var_144_8 + arg_144_0 then
				var_144_6.localPosition = Vector3.New(0, 100, 0)
				var_144_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_6.position).x, (manager.ui.mainCamera.transform.position - var_144_6.position).y, (manager.ui.mainCamera.transform.position - var_144_6.position).z)
				var_144_6.localEulerAngles.z = 0
				var_144_6.localEulerAngles.x = 0
				var_144_6.localEulerAngles = var_144_6.localEulerAngles

				local var_144_9 = GameObjectTools.GetOrAddComponent(var_144_6.gameObject, typeof(DynamicBoneHelper))

				if var_144_9 then
					var_144_9:EnableDynamicBone(true)
				end
			end

			local var_144_10 = arg_141_1.actors_["10002ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10002ui_story = var_144_10.localPosition
			end

			local var_144_11 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_11 then
				var_144_10.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10002ui_story, Vector3.New(0, -1.2, -5.8), (arg_141_1.time_ - 0) / var_144_11)
				var_144_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_10.position).x, (manager.ui.mainCamera.transform.position - var_144_10.position).y, (manager.ui.mainCamera.transform.position - var_144_10.position).z)
				var_144_10.localEulerAngles.z = 0
				var_144_10.localEulerAngles.x = 0
				var_144_10.localEulerAngles = var_144_10.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_11 and arg_141_1.time_ < 0 + var_144_11 + arg_144_0 then
				var_144_10.localPosition = Vector3.New(0, -1.2, -5.8)
				var_144_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_10.position).x, (manager.ui.mainCamera.transform.position - var_144_10.position).y, (manager.ui.mainCamera.transform.position - var_144_10.position).z)
				var_144_10.localEulerAngles.z = 0
				var_144_10.localEulerAngles.x = 0
				var_144_10.localEulerAngles = var_144_10.localEulerAngles
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_144_12 = 0
			local var_144_13 = 0.475

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_14 = arg_141_1:GetWordFromCfg(102081035)
				local var_144_15 = arg_141_1:FormatText(var_144_14.content)

				arg_141_1.text_.text = var_144_15

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 19 <= 0 and var_144_13 or var_144_13 * (utf8.len(var_144_15) / 19)

				if (19 <= 0 and var_144_13 or var_144_13 * (utf8.len(var_144_15) / 19)) > 0 and var_144_13 < var_144_17 then
					arg_141_1.talkMaxDuration = var_144_17

					if var_144_17 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_15
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102081", "102081035", "story_v_out_102081.awb") ~= 0 then
					local var_144_18 = manager.audio:GetVoiceLength("story_v_out_102081", "102081035", "story_v_out_102081.awb") / 1000

					if var_144_18 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_18 + var_144_12
					end

					if var_144_14.prefab_name ~= "" and arg_141_1.actors_[var_144_14.prefab_name] ~= nil then
						local var_144_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_14.prefab_name].transform, "story_v_out_102081", "102081035", "story_v_out_102081.awb")

						arg_141_1:RecordAudio("102081035", var_144_19)
						arg_141_1:RecordAudio("102081035", var_144_19)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_102081", "102081035", "story_v_out_102081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_102081", "102081035", "story_v_out_102081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_20 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_20 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_20

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_20 and arg_141_1.time_ < var_144_12 + var_144_20 + arg_144_0 then
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
