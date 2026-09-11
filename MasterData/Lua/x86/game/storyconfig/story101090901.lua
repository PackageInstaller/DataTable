return {
	Play109091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109091001
		arg_1_1.duration_ = 12.43

		local var_1_0 = {
			ja = 9.2,
			ko = 8.233,
			zh = 8.633,
			en = 12.433
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
				arg_1_0:Play109091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C07_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C07_1")
				var_4_0.name = "C07_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C07_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C07_1

				arg_1_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C07_1" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C07_1:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC07_1 = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC07_1 = var_4_4
				end

				arg_1_1.var_.alphaOldValueC07_1 = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC07_1 then
					arg_1_1.var_.alphaMatValueC07_1.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC07_1, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC07_1 then
				arg_1_1.var_.alphaMatValueC07_1.color.a = 1
				arg_1_1.var_.alphaMatValueC07_1.color = arg_1_1.var_.alphaMatValueC07_1.color
			end

			local var_4_6 = "4014_tpose"

			if arg_1_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_4_7 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_1_1.stage_.transform)

				var_4_7.name = var_4_6
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_6] = var_4_7

				local var_4_8 = var_4_7:GetComponentInChildren(typeof(CharacterEffect))

				var_4_8.enabled = true

				local var_4_9 = GameObjectTools.GetOrAddComponent(var_4_7, typeof(DynamicBoneHelper))

				if var_4_9 then
					var_4_9:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_8.transform, false)

				arg_1_1.var_[var_4_6 .. "Animator"] = var_4_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_6 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_6 .. "LipSync"] = var_4_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_10 = arg_1_1.actors_["4014_tpose"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos4014_tpose = var_4_10.localPosition

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_10.gameObject, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end
			end

			local var_4_12 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_12 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_1_1.time_ - 1.8) / var_4_12)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_12 and arg_1_1.time_ < 1.8 + var_4_12 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0, -1.95, -4.2)
				var_4_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_10.position).x, (manager.ui.mainCamera.transform.position - var_4_10.position).y, (manager.ui.mainCamera.transform.position - var_4_10.position).z)
				var_4_10.localEulerAngles.z = 0
				var_4_10.localEulerAngles.x = 0
				var_4_10.localEulerAngles = var_4_10.localEulerAngles

				local var_4_13 = GameObjectTools.GetOrAddComponent(var_4_10.gameObject, typeof(DynamicBoneHelper))

				if var_4_13 then
					var_4_13:EnableDynamicBone(true)
				end
			end

			local var_4_14 = arg_1_1.actors_["4014_tpose"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect4014_tpose == nil then
				arg_1_1.var_.characterEffect4014_tpose = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect4014_tpose and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect4014_tpose then
				arg_1_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 2 and arg_1_1.time_ < var_4_20 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 0.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(109091001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 26 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 26)

				if (26 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 26)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091001", "story_v_out_109091.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_109091", "109091001", "story_v_out_109091.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_109091", "109091001", "story_v_out_109091.awb")

						arg_1_1:RecordAudio("109091001", var_4_29)
						arg_1_1:RecordAudio("109091001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109091", "109091001", "story_v_out_109091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109091", "109091001", "story_v_out_109091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play109091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109091002
		arg_8_1.duration_ = 4.03

		local var_8_0 = {
			ja = 4.033,
			ko = 3.733,
			zh = 3.766,
			en = 3.633
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.3

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(109091002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 12 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 12)

				if (12 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 12)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091002", "story_v_out_109091.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091002", "story_v_out_109091.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_109091", "109091002", "story_v_out_109091.awb")

						arg_8_1:RecordAudio("109091002", var_11_6)
						arg_8_1:RecordAudio("109091002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_109091", "109091002", "story_v_out_109091.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_109091", "109091002", "story_v_out_109091.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play109091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109091003
		arg_12_1.duration_ = 5.9

		local var_12_0 = {
			ja = 2.733,
			ko = 4.333,
			zh = 5.9,
			en = 4.433
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play109091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1050ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1050ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1050ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1050ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1050ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1050ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1050ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1050ui_story, Vector3.New(0, -1, -6.1), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -1, -6.1)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1050ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1050ui_story == nil then
				arg_12_1.var_.characterEffect1050ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1050ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1050ui_story then
				arg_12_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action7_1")
			end

			local var_15_8 = arg_12_1.actors_["4014_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos4014_tpose = var_15_8.localPosition

				local var_15_9 = GameObjectTools.GetOrAddComponent(var_15_8.gameObject, typeof(DynamicBoneHelper))

				if var_15_9 then
					var_15_9:EnableDynamicBone(false)
				end
			end

			local var_15_10 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_10 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_10)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_10 and arg_12_1.time_ < 0 + var_15_10 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, 100, 0)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles

				local var_15_11 = GameObjectTools.GetOrAddComponent(var_15_8.gameObject, typeof(DynamicBoneHelper))

				if var_15_11 then
					var_15_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_15_12 = 0
			local var_15_13 = 0.325

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_12 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:GetWordFromCfg(109091003)
				local var_15_15 = arg_12_1:FormatText(var_15_14.content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 13 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 13)

				if (13 <= 0 and var_15_13 or var_15_13 * (utf8.len(var_15_15) / 13)) > 0 and var_15_13 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_12
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091003", "story_v_out_109091.awb") ~= 0 then
					local var_15_18 = manager.audio:GetVoiceLength("story_v_out_109091", "109091003", "story_v_out_109091.awb") / 1000

					if var_15_18 + var_15_12 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_18 + var_15_12
					end

					if var_15_14.prefab_name ~= "" and arg_12_1.actors_[var_15_14.prefab_name] ~= nil then
						local var_15_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_14.prefab_name].transform, "story_v_out_109091", "109091003", "story_v_out_109091.awb")

						arg_12_1:RecordAudio("109091003", var_15_19)
						arg_12_1:RecordAudio("109091003", var_15_19)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109091", "109091003", "story_v_out_109091.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109091", "109091003", "story_v_out_109091.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_20 = math.max(var_15_13, arg_12_1.talkMaxDuration)

			if var_15_12 <= arg_12_1.time_ and arg_12_1.time_ < var_15_12 + var_15_20 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_12) / var_15_20

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_12 + var_15_20 and arg_12_1.time_ < var_15_12 + var_15_20 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play109091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109091004
		arg_16_1.duration_ = 8.7

		local var_16_0 = {
			ja = 8.7,
			ko = 6.1,
			zh = 5.833,
			en = 5.6
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play109091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1050ui_story = arg_16_1.actors_["1050ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1050ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1050ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).z)
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles = arg_16_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1050ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1050ui_story"].transform.position).z)
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1050ui_story"].transform.localEulerAngles = arg_16_1.actors_["1050ui_story"].transform.localEulerAngles
			end

			local var_19_1 = 0
			local var_19_2 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(109091004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 26 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 26)

				if (26 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_4) / 26)) > 0 and var_19_2 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091004", "story_v_out_109091.awb") ~= 0 then
					local var_19_7 = manager.audio:GetVoiceLength("story_v_out_109091", "109091004", "story_v_out_109091.awb") / 1000

					if var_19_7 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_1
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_109091", "109091004", "story_v_out_109091.awb")

						arg_16_1:RecordAudio("109091004", var_19_8)
						arg_16_1:RecordAudio("109091004", var_19_8)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109091", "109091004", "story_v_out_109091.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109091", "109091004", "story_v_out_109091.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_9 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_9 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_9

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_9 and arg_16_1.time_ < var_19_1 + var_19_9 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play109091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109091005
		arg_20_1.duration_ = 8.17

		local var_20_0 = {
			ja = 5.933,
			ko = 5.633,
			zh = 5.6,
			en = 8.166
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.775

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:GetWordFromCfg(109091005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 31)

				if (31 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 31)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091005", "story_v_out_109091.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091005", "story_v_out_109091.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_109091", "109091005", "story_v_out_109091.awb")

						arg_20_1:RecordAudio("109091005", var_23_6)
						arg_20_1:RecordAudio("109091005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109091", "109091005", "story_v_out_109091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109091", "109091005", "story_v_out_109091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_7 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_7

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109091006
		arg_24_1.duration_ = 5.4

		local var_24_0 = {
			ja = 2.6,
			ko = 5.4,
			zh = 4.333,
			en = 3.266
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play109091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos4014_tpose = arg_24_1.actors_["4014_tpose"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).z)
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles = arg_24_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, -1.95, -4.2)
				arg_24_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).z)
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles = arg_24_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["4014_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect4014_tpose == nil then
				arg_24_1.var_.characterEffect4014_tpose = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect4014_tpose and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect4014_tpose then
				arg_24_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_27_6 = 0
			local var_27_7 = 0.45

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(109091006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 18 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 18)

				if (18 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 18)) > 0 and var_27_7 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091006", "story_v_out_109091.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_109091", "109091006", "story_v_out_109091.awb") / 1000

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_109091", "109091006", "story_v_out_109091.awb")

						arg_24_1:RecordAudio("109091006", var_27_13)
						arg_24_1:RecordAudio("109091006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109091", "109091006", "story_v_out_109091.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109091", "109091006", "story_v_out_109091.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play109091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109091007
		arg_28_1.duration_ = 5.93

		local var_28_0 = {
			ja = 4.233,
			ko = 5.933,
			zh = 5.666,
			en = 4.266
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.625

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(109091007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 25 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 25)

				if (25 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 25)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091007", "story_v_out_109091.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091007", "story_v_out_109091.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_109091", "109091007", "story_v_out_109091.awb")

						arg_28_1:RecordAudio("109091007", var_31_6)
						arg_28_1:RecordAudio("109091007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109091", "109091007", "story_v_out_109091.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109091", "109091007", "story_v_out_109091.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play109091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109091008
		arg_32_1.duration_ = 3.57

		local var_32_0 = {
			ja = 2.8,
			ko = 2.166,
			zh = 1.999999999999,
			en = 3.566
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play109091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos4014_tpose = arg_32_1.actors_["4014_tpose"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).z)
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles = arg_32_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4014_tpose"].transform.position).z)
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["4014_tpose"].transform.localEulerAngles = arg_32_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = "1099ui_story"

			if arg_32_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_35_4 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_32_1.stage_.transform)

				var_35_4.name = var_35_3
				var_35_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_[var_35_3] = var_35_4

				local var_35_5 = var_35_4:GetComponentInChildren(typeof(CharacterEffect))

				var_35_5.enabled = true

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_4, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_5.transform, false)

				arg_32_1.var_[var_35_3 .. "Animator"] = var_35_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_[var_35_3 .. "Animator"].applyRootMotion = true
				arg_32_1.var_[var_35_3 .. "LipSync"] = var_35_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_7 = arg_32_1.actors_["1099ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1099ui_story = var_35_7.localPosition
			end

			local var_35_8 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 then
				var_35_7.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_32_1.time_ - 0) / var_35_8)
				var_35_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_7.position).x, (manager.ui.mainCamera.transform.position - var_35_7.position).y, (manager.ui.mainCamera.transform.position - var_35_7.position).z)
				var_35_7.localEulerAngles.z = 0
				var_35_7.localEulerAngles.x = 0
				var_35_7.localEulerAngles = var_35_7.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 then
				var_35_7.localPosition = Vector3.New(0, -1.08, -5.9)
				var_35_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_7.position).x, (manager.ui.mainCamera.transform.position - var_35_7.position).y, (manager.ui.mainCamera.transform.position - var_35_7.position).z)
				var_35_7.localEulerAngles.z = 0
				var_35_7.localEulerAngles.x = 0
				var_35_7.localEulerAngles = var_35_7.localEulerAngles
			end

			local var_35_9 = arg_32_1.actors_["1099ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1099ui_story == nil then
				arg_32_1.var_.characterEffect1099ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_10 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 and not isNil(var_35_9) then
				if arg_32_1.var_.characterEffect1099ui_story and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1099ui_story then
				arg_32_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action7_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_35_12 = 0
			local var_35_13 = 0.2

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(109091008)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 8 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 8)

				if (8 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 8)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091008", "story_v_out_109091.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_109091", "109091008", "story_v_out_109091.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_109091", "109091008", "story_v_out_109091.awb")

						arg_32_1:RecordAudio("109091008", var_35_19)
						arg_32_1:RecordAudio("109091008", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109091", "109091008", "story_v_out_109091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109091", "109091008", "story_v_out_109091.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play109091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109091009
		arg_36_1.duration_ = 5.9

		local var_36_0 = {
			ja = 3.3,
			ko = 2.8,
			zh = 5.4,
			en = 5.9
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play109091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1099ui_story = arg_36_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).z)
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles = arg_36_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1099ui_story"].transform.position).z)
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1099ui_story"].transform.localEulerAngles = arg_36_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["4014_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4014_tpose = var_39_1.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_36_1.time_ - 0) / var_39_3)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, -1.95, -4.2)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(true)
				end
			end

			local var_39_5 = arg_36_1.actors_["4014_tpose"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect4014_tpose == nil then
				arg_36_1.var_.characterEffect4014_tpose = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect4014_tpose and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect4014_tpose then
				arg_36_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_39_8 = 0
			local var_39_9 = 0.525

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(109091009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 21 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 21)

				if (21 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 21)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091009", "story_v_out_109091.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_109091", "109091009", "story_v_out_109091.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_109091", "109091009", "story_v_out_109091.awb")

						arg_36_1:RecordAudio("109091009", var_39_15)
						arg_36_1:RecordAudio("109091009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109091", "109091009", "story_v_out_109091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109091", "109091009", "story_v_out_109091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play109091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109091010
		arg_40_1.duration_ = 1.5

		local var_40_0 = {
			ja = 1.5,
			ko = 1.233,
			zh = 1.066,
			en = 1.4
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
				arg_40_0:Play109091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) and arg_40_1.var_.characterEffect4014_tpose == nil then
				arg_40_1.var_.characterEffect4014_tpose = arg_40_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) then
				if arg_40_1.var_.characterEffect4014_tpose and not isNil(arg_40_1.actors_["4014_tpose"]) then
					arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_40_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4014_tpose"]) and arg_40_1.var_.characterEffect4014_tpose then
				arg_40_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_40_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_9", "se_story_9_hit02", "")
			end

			local var_43_2 = 0
			local var_43_3 = 0.125

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_4 = arg_40_1:GetWordFromCfg(109091010)
				local var_43_5 = arg_40_1:FormatText(var_43_4.content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 5 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 5)

				if (5 <= 0 and var_43_3 or var_43_3 * (utf8.len(var_43_5) / 5)) > 0 and var_43_3 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_2
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091010", "story_v_out_109091.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_109091", "109091010", "story_v_out_109091.awb") / 1000

					if var_43_8 + var_43_2 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_2
					end

					if var_43_4.prefab_name ~= "" and arg_40_1.actors_[var_43_4.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_4.prefab_name].transform, "story_v_out_109091", "109091010", "story_v_out_109091.awb")

						arg_40_1:RecordAudio("109091010", var_43_9)
						arg_40_1:RecordAudio("109091010", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109091", "109091010", "story_v_out_109091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109091", "109091010", "story_v_out_109091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_3, arg_40_1.talkMaxDuration)

			if var_43_2 <= arg_40_1.time_ and arg_40_1.time_ < var_43_2 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_2) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_2 + var_43_10 and arg_40_1.time_ < var_43_2 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109091011
		arg_44_1.duration_ = 5.83

		local var_44_0 = {
			ja = 5.833,
			ko = 3.933,
			zh = 5.266,
			en = 4.566
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
				arg_44_0:Play109091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["4014_tpose"]) and arg_44_1.var_.characterEffect4014_tpose == nil then
				arg_44_1.var_.characterEffect4014_tpose = arg_44_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["4014_tpose"]) then
				if arg_44_1.var_.characterEffect4014_tpose and not isNil(arg_44_1.actors_["4014_tpose"]) then
					arg_44_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["4014_tpose"]) and arg_44_1.var_.characterEffect4014_tpose then
				arg_44_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_47_2 = 0
			local var_47_3 = 0.525

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(109091011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 21 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 21)

				if (21 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 21)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091011", "story_v_out_109091.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_109091", "109091011", "story_v_out_109091.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_109091", "109091011", "story_v_out_109091.awb")

						arg_44_1:RecordAudio("109091011", var_47_9)
						arg_44_1:RecordAudio("109091011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109091", "109091011", "story_v_out_109091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109091", "109091011", "story_v_out_109091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109091012
		arg_48_1.duration_ = 5.83

		local var_48_0 = {
			ja = 4.533,
			ko = 5.8,
			zh = 5.833,
			en = 5.366
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
				arg_48_0:Play109091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(109091012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 20)

				if (20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 20)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091012", "story_v_out_109091.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091012", "story_v_out_109091.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_109091", "109091012", "story_v_out_109091.awb")

						arg_48_1:RecordAudio("109091012", var_51_6)
						arg_48_1:RecordAudio("109091012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109091", "109091012", "story_v_out_109091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109091", "109091012", "story_v_out_109091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109091013
		arg_52_1.duration_ = 15.2

		local var_52_0 = {
			ja = 10.7,
			ko = 12.4,
			zh = 15.2,
			en = 14.233
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(109091013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 54 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 54)

				if (54 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 54)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091013", "story_v_out_109091.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091013", "story_v_out_109091.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_109091", "109091013", "story_v_out_109091.awb")

						arg_52_1:RecordAudio("109091013", var_55_6)
						arg_52_1:RecordAudio("109091013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109091", "109091013", "story_v_out_109091.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109091", "109091013", "story_v_out_109091.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109091014
		arg_56_1.duration_ = 5.57

		local var_56_0 = {
			ja = 5.566,
			ko = 3.966,
			zh = 4.1,
			en = 4.8
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
				arg_56_0:Play109091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["4014_tpose"]) and arg_56_1.var_.characterEffect4014_tpose == nil then
				arg_56_1.var_.characterEffect4014_tpose = arg_56_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["4014_tpose"]) then
				if arg_56_1.var_.characterEffect4014_tpose and not isNil(arg_56_1.actors_["4014_tpose"]) then
					arg_56_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_56_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["4014_tpose"]) and arg_56_1.var_.characterEffect4014_tpose then
				arg_56_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_56_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.525

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(109091014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 21 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 21)

				if (21 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 21)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091014", "story_v_out_109091.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_109091", "109091014", "story_v_out_109091.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_109091", "109091014", "story_v_out_109091.awb")

						arg_56_1:RecordAudio("109091014", var_59_8)
						arg_56_1:RecordAudio("109091014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109091", "109091014", "story_v_out_109091.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109091", "109091014", "story_v_out_109091.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play109091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109091015
		arg_60_1.duration_ = 2.8

		local var_60_0 = {
			ja = 1.066,
			ko = 2.566,
			zh = 2.8,
			en = 2.566
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play109091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["4014_tpose"]) and arg_60_1.var_.characterEffect4014_tpose == nil then
				arg_60_1.var_.characterEffect4014_tpose = arg_60_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["4014_tpose"]) then
				if arg_60_1.var_.characterEffect4014_tpose and not isNil(arg_60_1.actors_["4014_tpose"]) then
					arg_60_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["4014_tpose"]) and arg_60_1.var_.characterEffect4014_tpose then
				arg_60_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_9", "se_story_9_hit03", "")
			end

			local var_63_3 = 0
			local var_63_4 = 0.225

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_5 = arg_60_1:GetWordFromCfg(109091015)
				local var_63_6 = arg_60_1:FormatText(var_63_5.content)

				arg_60_1.text_.text = var_63_6

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_8 = 9 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_6) / 9)

				if (9 <= 0 and var_63_4 or var_63_4 * (utf8.len(var_63_6) / 9)) > 0 and var_63_4 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8

					if var_63_8 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_3
					end
				end

				arg_60_1.text_.text = var_63_6
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091015", "story_v_out_109091.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_109091", "109091015", "story_v_out_109091.awb") / 1000

					if var_63_9 + var_63_3 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_3
					end

					if var_63_5.prefab_name ~= "" and arg_60_1.actors_[var_63_5.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_5.prefab_name].transform, "story_v_out_109091", "109091015", "story_v_out_109091.awb")

						arg_60_1:RecordAudio("109091015", var_63_10)
						arg_60_1:RecordAudio("109091015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109091", "109091015", "story_v_out_109091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109091", "109091015", "story_v_out_109091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_4, arg_60_1.talkMaxDuration)

			if var_63_3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_3 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_3) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_3 + var_63_11 and arg_60_1.time_ < var_63_3 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play109091016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109091016
		arg_64_1.duration_ = 1.73

		local var_64_0 = {
			ja = 1.2,
			ko = 1.733,
			zh = 1.433,
			en = 1.433
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
				arg_64_0:Play109091017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.2 < arg_64_1.time_ and arg_64_1.time_ <= 0.2 + arg_67_0 then
				arg_64_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_67_0 = 0.2

			if 0.2 <= arg_64_1.time_ and arg_64_1.time_ < 0.2 + var_67_0 then
				local var_67_1, var_67_2 = math.modf((arg_64_1.time_ - 0.2) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_67_2 * 0.13, var_67_2 * 0.13, var_67_2 * 0.13) + arg_64_1.var_.shakeOldPos
			end

			if arg_64_1.time_ >= 0.2 + var_67_0 and arg_64_1.time_ < 0.2 + var_67_0 + arg_67_0 then
				manager.ui.mainCamera.transform.localPosition = arg_64_1.var_.shakeOldPos
			end

			local var_67_3 = arg_64_1.actors_["4014_tpose"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos4014_tpose = var_67_3.localPosition

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(false)
				end
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_5)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0, 100, 0)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(true)
				end
			end

			local var_67_7 = 0
			local var_67_8 = 0.125

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[76].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6065")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(109091016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_12 = 5 <= 0 and var_67_8 or var_67_8 * (utf8.len(var_67_10) / 5)

				if (5 <= 0 and var_67_8 or var_67_8 * (utf8.len(var_67_10) / 5)) > 0 and var_67_8 < var_67_12 then
					arg_64_1.talkMaxDuration = var_67_12

					if var_67_12 + var_67_7 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_12 + var_67_7
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091016", "story_v_out_109091.awb") ~= 0 then
					local var_67_13 = manager.audio:GetVoiceLength("story_v_out_109091", "109091016", "story_v_out_109091.awb") / 1000

					if var_67_13 + var_67_7 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_7
					end

					if var_67_9.prefab_name ~= "" and arg_64_1.actors_[var_67_9.prefab_name] ~= nil then
						local var_67_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_9.prefab_name].transform, "story_v_out_109091", "109091016", "story_v_out_109091.awb")

						arg_64_1:RecordAudio("109091016", var_67_14)
						arg_64_1:RecordAudio("109091016", var_67_14)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109091", "109091016", "story_v_out_109091.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109091", "109091016", "story_v_out_109091.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_15 = math.max(var_67_8, arg_64_1.talkMaxDuration)

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_15 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_7) / var_67_15

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_7 + var_67_15 and arg_64_1.time_ < var_67_7 + var_67_15 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play109091017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109091017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play109091018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.825

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(109091017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 33 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 33)

				if (33 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 33)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109091018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109091018
		arg_72_1.duration_ = 6.47

		local var_72_0 = {
			ja = 6.466,
			ko = 3.7,
			zh = 5.333,
			en = 4
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
				arg_72_0:Play109091019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(109091018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 19)

				if (19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 19)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091018", "story_v_out_109091.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_109091", "109091018", "story_v_out_109091.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_109091", "109091018", "story_v_out_109091.awb")

						arg_72_1:RecordAudio("109091018", var_75_6)
						arg_72_1:RecordAudio("109091018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_109091", "109091018", "story_v_out_109091.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_109091", "109091018", "story_v_out_109091.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play109091019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109091019
		arg_76_1.duration_ = 7.17

		local var_76_0 = {
			ja = 7.166,
			ko = 5.1,
			zh = 5.966,
			en = 4.933
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
				arg_76_0:Play109091020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos4014_tpose = arg_76_1.actors_["4014_tpose"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).z)
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles = arg_76_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, -1.95, -4.2)
				arg_76_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["4014_tpose"].transform.position).z)
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["4014_tpose"].transform.localEulerAngles = arg_76_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = arg_76_1.actors_["4014_tpose"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect4014_tpose == nil then
				arg_76_1.var_.characterEffect4014_tpose = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect4014_tpose and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect4014_tpose then
				arg_76_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_79_6 = 0
			local var_79_7 = 0.575

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(109091019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 23 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 23)

				if (23 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 23)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091019", "story_v_out_109091.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_109091", "109091019", "story_v_out_109091.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_109091", "109091019", "story_v_out_109091.awb")

						arg_76_1:RecordAudio("109091019", var_79_13)
						arg_76_1:RecordAudio("109091019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109091", "109091019", "story_v_out_109091.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109091", "109091019", "story_v_out_109091.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play109091020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109091020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play109091021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) and arg_80_1.var_.characterEffect4014_tpose == nil then
				arg_80_1.var_.characterEffect4014_tpose = arg_80_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) then
				if arg_80_1.var_.characterEffect4014_tpose and not isNil(arg_80_1.actors_["4014_tpose"]) then
					arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_80_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["4014_tpose"]) and arg_80_1.var_.characterEffect4014_tpose then
				arg_80_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_80_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 1

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(109091020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 40 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 40)

				if (40 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 40)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play109091021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 109091021
		arg_84_1.duration_ = 4.97

		local var_84_0 = {
			ja = 2.833,
			ko = 4.966,
			zh = 3.2,
			en = 2.233
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play109091022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["4014_tpose"]) and arg_84_1.var_.characterEffect4014_tpose == nil then
				arg_84_1.var_.characterEffect4014_tpose = arg_84_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["4014_tpose"]) then
				if arg_84_1.var_.characterEffect4014_tpose and not isNil(arg_84_1.actors_["4014_tpose"]) then
					arg_84_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["4014_tpose"]) and arg_84_1.var_.characterEffect4014_tpose then
				arg_84_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_87_2 = 0
			local var_87_3 = 0.35

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(109091021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 14 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 14)

				if (14 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 14)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091021", "story_v_out_109091.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_109091", "109091021", "story_v_out_109091.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_109091", "109091021", "story_v_out_109091.awb")

						arg_84_1:RecordAudio("109091021", var_87_9)
						arg_84_1:RecordAudio("109091021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_109091", "109091021", "story_v_out_109091.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_109091", "109091021", "story_v_out_109091.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play109091022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 109091022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play109091023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				local var_91_1, var_91_2 = math.modf((arg_88_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_91_2 * 0.13, var_91_2 * 0.13, var_91_2 * 0.13) + arg_88_1.var_.shakeOldPos
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				manager.ui.mainCamera.transform.localPosition = arg_88_1.var_.shakeOldPos
			end

			local var_91_3 = arg_88_1.actors_["4014_tpose"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect4014_tpose == nil then
				arg_88_1.var_.characterEffect4014_tpose = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect4014_tpose and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_88_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_4)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect4014_tpose then
				arg_88_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_88_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_91_5 = 0
			local var_91_6 = 0.1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(109091022).content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 4 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 4)

				if (4 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 4)) > 0 and var_91_6 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_10 and arg_88_1.time_ < var_91_5 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play109091023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 109091023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play109091024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shoot", "")
			end

			local var_95_1 = 0
			local var_95_2 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(109091023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 17 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 17)

				if (17 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 17)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play109091024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 109091024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play109091025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos4014_tpose = arg_96_1.actors_["4014_tpose"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.5

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).z)
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles = arg_96_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, -1.95, -4.2)
				arg_96_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["4014_tpose"].transform.position).z)
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["4014_tpose"].transform.localEulerAngles = arg_96_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = 0
			local var_99_4 = 1.025

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_5 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(109091024).content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 41 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 41)

				if (41 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 41)) > 0 and var_99_4 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_3 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_3
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_4, arg_96_1.talkMaxDuration)

			if var_99_3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_3 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_3) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_3 + var_99_8 and arg_96_1.time_ < var_99_3 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play109091025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 109091025
		arg_100_1.duration_ = 9.73

		local var_100_0 = {
			ja = 9.733,
			ko = 6.366,
			zh = 4.566,
			en = 6.566
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
				arg_100_0:Play109091026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["4014_tpose"]) and arg_100_1.var_.characterEffect4014_tpose == nil then
				arg_100_1.var_.characterEffect4014_tpose = arg_100_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["4014_tpose"]) then
				if arg_100_1.var_.characterEffect4014_tpose and not isNil(arg_100_1.actors_["4014_tpose"]) then
					arg_100_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["4014_tpose"]) and arg_100_1.var_.characterEffect4014_tpose then
				arg_100_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_103_2 = 0
			local var_103_3 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(109091025)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 17 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 17)

				if (17 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 17)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091025", "story_v_out_109091.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_109091", "109091025", "story_v_out_109091.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_109091", "109091025", "story_v_out_109091.awb")

						arg_100_1:RecordAudio("109091025", var_103_9)
						arg_100_1:RecordAudio("109091025", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_109091", "109091025", "story_v_out_109091.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_109091", "109091025", "story_v_out_109091.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play109091026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 109091026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play109091027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.15

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(109091026).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 46 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 46)

				if (46 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 46)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play109091027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 109091027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play109091028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(109091027).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 25 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 25)

				if (25 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 25)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play109091028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 109091028
		arg_112_1.duration_ = 6.53

		local var_112_0 = {
			ja = 4.6,
			ko = 6.533,
			zh = 5.766,
			en = 5.933
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
				arg_112_0:Play109091029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos4014_tpose = arg_112_1.actors_["4014_tpose"].transform.localPosition

				local var_115_0 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_0 then
					var_115_0:EnableDynamicBone(false)
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_1)
				arg_112_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).z)
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles = arg_112_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["4014_tpose"].transform.position).z)
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["4014_tpose"].transform.localEulerAngles = arg_112_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_115_2 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(true)
				end
			end

			local var_115_3 = 0
			local var_115_4 = 0.7

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_5 = arg_112_1:GetWordFromCfg(109091028)
				local var_115_6 = arg_112_1:FormatText(var_115_5.content)

				arg_112_1.text_.text = var_115_6

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_8 = 28 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_6) / 28)

				if (28 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_6) / 28)) > 0 and var_115_4 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_6
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091028", "story_v_out_109091.awb") ~= 0 then
					local var_115_9 = manager.audio:GetVoiceLength("story_v_out_109091", "109091028", "story_v_out_109091.awb") / 1000

					if var_115_9 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_3
					end

					if var_115_5.prefab_name ~= "" and arg_112_1.actors_[var_115_5.prefab_name] ~= nil then
						local var_115_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_5.prefab_name].transform, "story_v_out_109091", "109091028", "story_v_out_109091.awb")

						arg_112_1:RecordAudio("109091028", var_115_10)
						arg_112_1:RecordAudio("109091028", var_115_10)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_109091", "109091028", "story_v_out_109091.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_109091", "109091028", "story_v_out_109091.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_11 and arg_112_1.time_ < var_115_3 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play109091029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 109091029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play109091030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(109091029).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 36 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 36)

				if (36 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 36)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play109091030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 109091030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play109091031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(109091030).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 44)

				if (44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 44)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play109091031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 109091031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play109091032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				local var_127_1, var_127_2 = math.modf((arg_124_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_127_2 * 0.13, var_127_2 * 0.13, var_127_2 * 0.13) + arg_124_1.var_.shakeOldPos
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				manager.ui.mainCamera.transform.localPosition = arg_124_1.var_.shakeOldPos
			end

			local var_127_3 = manager.ui.mainCamera.transform

			if 0.5 < arg_124_1.time_ and arg_124_1.time_ <= 0.5 + arg_127_0 then
				arg_124_1.var_.shakeOldPos = var_127_3.localPosition
			end

			local var_127_4 = 0.2

			if 0.5 <= arg_124_1.time_ and arg_124_1.time_ < 0.5 + var_127_4 then
				local var_127_5, var_127_6 = math.modf((arg_124_1.time_ - 0.5) / 0.099)

				var_127_3.localPosition = Vector3.New(var_127_6 * 0.13, var_127_6 * 0.13, var_127_6 * 0.13) + arg_124_1.var_.shakeOldPos
			end

			if arg_124_1.time_ >= 0.5 + var_127_4 and arg_124_1.time_ < 0.5 + var_127_4 + arg_127_0 then
				var_127_3.localPosition = arg_124_1.var_.shakeOldPos
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shoot", "")
			end

			local var_127_8 = 0
			local var_127_9 = 0.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(109091031).content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_12 = 8 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 8)

				if (8 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_10) / 8)) > 0 and var_127_9 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_13 and arg_124_1.time_ < var_127_8 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play109091032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 109091032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play109091033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1.05

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(109091032).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 39 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 39)

				if (39 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 39)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play109091033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 109091033
		arg_132_1.duration_ = 9.23

		local var_132_0 = {
			ja = 5.7,
			ko = 7.9,
			zh = 7.666,
			en = 9.233
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play109091034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos4014_tpose = arg_132_1.actors_["4014_tpose"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).z)
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles = arg_132_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, -1.95, -4.2)
				arg_132_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["4014_tpose"].transform.position).z)
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["4014_tpose"].transform.localEulerAngles = arg_132_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = arg_132_1.actors_["4014_tpose"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect4014_tpose == nil then
				arg_132_1.var_.characterEffect4014_tpose = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect4014_tpose and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect4014_tpose then
				arg_132_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			local var_135_6 = 0
			local var_135_7 = 0.75

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:GetWordFromCfg(109091033)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 30 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 30)

				if (30 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 30)) > 0 and var_135_7 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091033", "story_v_out_109091.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_109091", "109091033", "story_v_out_109091.awb") / 1000

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_109091", "109091033", "story_v_out_109091.awb")

						arg_132_1:RecordAudio("109091033", var_135_13)
						arg_132_1:RecordAudio("109091033", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_109091", "109091033", "story_v_out_109091.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_109091", "109091033", "story_v_out_109091.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play109091034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 109091034
		arg_136_1.duration_ = 3.3

		local var_136_0 = {
			ja = 2.5,
			ko = 3.3,
			zh = 3.066,
			en = 2.866
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play109091035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos4014_tpose = arg_136_1.actors_["4014_tpose"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).z)
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles = arg_136_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["4014_tpose"].transform.position).z)
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["4014_tpose"].transform.localEulerAngles = arg_136_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["1099ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1099ui_story = var_139_3.localPosition
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_136_1.time_ - 0) / var_139_4)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_139_5 = arg_136_1.actors_["1099ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story == nil then
				arg_136_1.var_.characterEffect1099ui_story = var_139_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_6 and not isNil(var_139_5) then
				if arg_136_1.var_.characterEffect1099ui_story and not isNil(var_139_5) then
					arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_6 and arg_136_1.time_ < 0 + var_139_6 + arg_139_0 and not isNil(var_139_5) and arg_136_1.var_.characterEffect1099ui_story then
				arg_136_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_139_8 = 0
			local var_139_9 = 0.35

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_8 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_10 = arg_136_1:GetWordFromCfg(109091034)
				local var_139_11 = arg_136_1:FormatText(var_139_10.content)

				arg_136_1.text_.text = var_139_11

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_13 = 14 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 14)

				if (14 <= 0 and var_139_9 or var_139_9 * (utf8.len(var_139_11) / 14)) > 0 and var_139_9 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_8
					end
				end

				arg_136_1.text_.text = var_139_11
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091034", "story_v_out_109091.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_109091", "109091034", "story_v_out_109091.awb") / 1000

					if var_139_14 + var_139_8 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_8
					end

					if var_139_10.prefab_name ~= "" and arg_136_1.actors_[var_139_10.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_10.prefab_name].transform, "story_v_out_109091", "109091034", "story_v_out_109091.awb")

						arg_136_1:RecordAudio("109091034", var_139_15)
						arg_136_1:RecordAudio("109091034", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_109091", "109091034", "story_v_out_109091.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_109091", "109091034", "story_v_out_109091.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_9, arg_136_1.talkMaxDuration)

			if var_139_8 <= arg_136_1.time_ and arg_136_1.time_ < var_139_8 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_8) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_8 + var_139_16 and arg_136_1.time_ < var_139_8 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play109091035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 109091035
		arg_140_1.duration_ = 4.4

		local var_140_0 = {
			ja = 4.4,
			ko = 3.766,
			zh = 4.033,
			en = 3.466
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play109091036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1099ui_story = arg_140_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).z)
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles = arg_140_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1099ui_story"].transform.position).z)
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1099ui_story"].transform.localEulerAngles = arg_140_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["4014_tpose"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos4014_tpose = var_143_1.localPosition

				local var_143_2 = GameObjectTools.GetOrAddComponent(var_143_1.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(false)
				end
			end

			local var_143_3 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_140_1.time_ - 0) / var_143_3)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, -1.95, -4.2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles

				local var_143_4 = GameObjectTools.GetOrAddComponent(var_143_1.gameObject, typeof(DynamicBoneHelper))

				if var_143_4 then
					var_143_4:EnableDynamicBone(true)
				end
			end

			local var_143_5 = arg_140_1.actors_["4014_tpose"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect4014_tpose == nil then
				arg_140_1.var_.characterEffect4014_tpose = var_143_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_6 and not isNil(var_143_5) then
				if arg_140_1.var_.characterEffect4014_tpose and not isNil(var_143_5) then
					arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_6 and arg_140_1.time_ < 0 + var_143_6 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect4014_tpose then
				arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action1_1")
			end

			local var_143_8 = 0
			local var_143_9 = 0.425

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(109091035)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 17 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 17)

				if (17 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 17)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091035", "story_v_out_109091.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_109091", "109091035", "story_v_out_109091.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_109091", "109091035", "story_v_out_109091.awb")

						arg_140_1:RecordAudio("109091035", var_143_15)
						arg_140_1:RecordAudio("109091035", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_109091", "109091035", "story_v_out_109091.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_109091", "109091035", "story_v_out_109091.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play109091036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 109091036
		arg_144_1.duration_ = 3.5

		local var_144_0 = {
			ja = 3,
			ko = 3.5,
			zh = 2.9,
			en = 1.999999999999
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play109091037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos4014_tpose = arg_144_1.actors_["4014_tpose"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).z)
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles = arg_144_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["4014_tpose"].transform.position).z)
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["4014_tpose"].transform.localEulerAngles = arg_144_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["1050ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1050ui_story = var_147_3.localPosition

				arg_144_1:ShowWeapon(arg_144_1.var_["1050ui_story" .. "Animator"].transform, true)
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_3.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1050ui_story, Vector3.New(-0.7, -1, -6.1), (arg_144_1.time_ - 0) / var_147_4)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_3.localPosition = Vector3.New(-0.7, -1, -6.1)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			local var_147_5 = arg_144_1.actors_["1050ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1050ui_story == nil then
				arg_144_1.var_.characterEffect1050ui_story = var_147_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_6 and not isNil(var_147_5) then
				if arg_144_1.var_.characterEffect1050ui_story and not isNil(var_147_5) then
					arg_144_1.var_.characterEffect1050ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_6 and arg_144_1.time_ < 0 + var_147_6 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1050ui_story then
				arg_144_1.var_.characterEffect1050ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/story1050/story1050action/1050action6_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_147_8 = 0
			local var_147_9 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:GetWordFromCfg(109091036)
				local var_147_11 = arg_144_1:FormatText(var_147_10.content)

				arg_144_1.text_.text = var_147_11

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_13 = 16 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 16)

				if (16 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_11) / 16)) > 0 and var_147_9 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_11
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091036", "story_v_out_109091.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_109091", "109091036", "story_v_out_109091.awb") / 1000

					if var_147_14 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_8
					end

					if var_147_10.prefab_name ~= "" and arg_144_1.actors_[var_147_10.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_10.prefab_name].transform, "story_v_out_109091", "109091036", "story_v_out_109091.awb")

						arg_144_1:RecordAudio("109091036", var_147_15)
						arg_144_1:RecordAudio("109091036", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_109091", "109091036", "story_v_out_109091.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_109091", "109091036", "story_v_out_109091.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_16 and arg_144_1.time_ < var_147_8 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play109091037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 109091037
		arg_148_1.duration_ = 5.83

		local var_148_0 = {
			ja = 5.833,
			ko = 4.633,
			zh = 4.5,
			en = 4.4
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
			arg_148_1.auto_ = false
		end

		function arg_148_1.playNext_(arg_150_0)
			arg_148_1.onStoryFinished_()
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1099ui_story = arg_148_1.actors_["1099ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1099ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).z)
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles = arg_148_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1099ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_148_1.actors_["1099ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1099ui_story"].transform.position).z)
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1099ui_story"].transform.localEulerAngles = arg_148_1.actors_["1099ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1099ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1099ui_story == nil then
				arg_148_1.var_.characterEffect1099ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1099ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1099ui_story then
				arg_148_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_151_4 = 0
			local var_151_5 = 0.625

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(109091037)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 24 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 24)

				if (24 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 24)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109091", "109091037", "story_v_out_109091.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_109091", "109091037", "story_v_out_109091.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_109091", "109091037", "story_v_out_109091.awb")

						arg_148_1:RecordAudio("109091037", var_151_11)
						arg_148_1:RecordAudio("109091037", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_109091", "109091037", "story_v_out_109091.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_109091", "109091037", "story_v_out_109091.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_109091.awb"
	}
}
