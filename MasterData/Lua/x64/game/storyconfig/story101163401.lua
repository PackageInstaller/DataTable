return {
	Play116341001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116341001
		arg_1_1.duration_ = 8.9

		local var_1_0 = {
			zh = 8.9,
			ja = 6.2
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
				arg_1_0:Play116341002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_4_0.name = "ST03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.866666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.866666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.775

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(116341001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 31 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 31)

				if (31 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 31)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341001", "story_v_out_116341.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_116341", "116341001", "story_v_out_116341.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_116341", "116341001", "story_v_out_116341.awb")

						arg_1_1:RecordAudio("116341001", var_4_22)
						arg_1_1:RecordAudio("116341001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116341", "116341001", "story_v_out_116341.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116341", "116341001", "story_v_out_116341.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116341002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116341002
		arg_9_1.duration_ = 3.1

		local var_9_0 = {
			zh = 2.133,
			ja = 3.1
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116341003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10032ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10032ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10032ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10032ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10032ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10032ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10032ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10032ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10032ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_5 = arg_9_1.actors_["10032ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10032ui_story == nil then
				arg_9_1.var_.characterEffect10032ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10032ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10032ui_story then
				arg_9_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(116341002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 4 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 4)

				if (4 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 4)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341002", "story_v_out_116341.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_116341", "116341002", "story_v_out_116341.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_116341", "116341002", "story_v_out_116341.awb")

						arg_9_1:RecordAudio("116341002", var_12_15)
						arg_9_1:RecordAudio("116341002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_116341", "116341002", "story_v_out_116341.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_116341", "116341002", "story_v_out_116341.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play116341003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116341003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116341004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10032ui_story = arg_13_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).z)
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles = arg_13_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10032ui_story"].transform.position).z)
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10032ui_story"].transform.localEulerAngles = arg_13_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_16_1 = 0
			local var_16_2 = 1.2

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116341003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 48 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 48)

				if (48 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 48)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play116341004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116341004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116341005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(116341004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116341005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116341005
		arg_21_1.duration_ = 7.33

		local var_21_0 = {
			zh = 7.1,
			ja = 7.333
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play116341006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.775

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(116341005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 31 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 31)

				if (31 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 31)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341005", "story_v_out_116341.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341005", "story_v_out_116341.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_116341", "116341005", "story_v_out_116341.awb")

						arg_21_1:RecordAudio("116341005", var_24_6)
						arg_21_1:RecordAudio("116341005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116341", "116341005", "story_v_out_116341.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116341", "116341005", "story_v_out_116341.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play116341006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116341006
		arg_25_1.duration_ = 2.07

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116341007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10032ui_story = arg_25_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).z)
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles = arg_25_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_25_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10032ui_story"].transform.position).z)
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10032ui_story"].transform.localEulerAngles = arg_25_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action453")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_1 = arg_25_1.actors_["10032ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10032ui_story == nil then
				arg_25_1.var_.characterEffect10032ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10032ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10032ui_story then
				arg_25_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 0.15

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(116341006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 6 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 6)

				if (6 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 6)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341006", "story_v_out_116341.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341006", "story_v_out_116341.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_116341", "116341006", "story_v_out_116341.awb")

						arg_25_1:RecordAudio("116341006", var_28_11)
						arg_25_1:RecordAudio("116341006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_116341", "116341006", "story_v_out_116341.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_116341", "116341006", "story_v_out_116341.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play116341007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116341007
		arg_29_1.duration_ = 8.53

		local var_29_0 = {
			zh = 5.433,
			ja = 8.533
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116341008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10032ui_story"]) and arg_29_1.var_.characterEffect10032ui_story == nil then
				arg_29_1.var_.characterEffect10032ui_story = arg_29_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10032ui_story"]) then
				if arg_29_1.var_.characterEffect10032ui_story and not isNil(arg_29_1.actors_["10032ui_story"]) then
					arg_29_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10032ui_story"]) and arg_29_1.var_.characterEffect10032ui_story then
				arg_29_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(116341007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 21 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 21)

				if (21 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_4) / 21)) > 0 and var_32_2 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341007", "story_v_out_116341.awb") ~= 0 then
					local var_32_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341007", "story_v_out_116341.awb") / 1000

					if var_32_7 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_1
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_116341", "116341007", "story_v_out_116341.awb")

						arg_29_1:RecordAudio("116341007", var_32_8)
						arg_29_1:RecordAudio("116341007", var_32_8)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_116341", "116341007", "story_v_out_116341.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_116341", "116341007", "story_v_out_116341.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_9 and arg_29_1.time_ < var_32_1 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play116341008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116341008
		arg_33_1.duration_ = 3.77

		local var_33_0 = {
			zh = 3.766,
			ja = 3.733
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116341009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10032ui_story = arg_33_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).z)
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles = arg_33_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_33_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10032ui_story"].transform.position).z)
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10032ui_story"].transform.localEulerAngles = arg_33_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_36_1 = arg_33_1.actors_["10032ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10032ui_story == nil then
				arg_33_1.var_.characterEffect10032ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect10032ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10032ui_story then
				arg_33_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_36_4 = 0
			local var_36_5 = 0.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(116341008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 11 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 11)

				if (11 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 11)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341008", "story_v_out_116341.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341008", "story_v_out_116341.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_116341", "116341008", "story_v_out_116341.awb")

						arg_33_1:RecordAudio("116341008", var_36_11)
						arg_33_1:RecordAudio("116341008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_116341", "116341008", "story_v_out_116341.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_116341", "116341008", "story_v_out_116341.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play116341009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116341009
		arg_37_1.duration_ = 1.5

		local var_37_0 = {
			zh = 1.1,
			ja = 1.5
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116341010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10032ui_story"]) and arg_37_1.var_.characterEffect10032ui_story == nil then
				arg_37_1.var_.characterEffect10032ui_story = arg_37_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10032ui_story"]) then
				if arg_37_1.var_.characterEffect10032ui_story and not isNil(arg_37_1.actors_["10032ui_story"]) then
					arg_37_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10032ui_story"]) and arg_37_1.var_.characterEffect10032ui_story then
				arg_37_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(116341009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 2 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 2)

				if (2 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 2)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341009", "story_v_out_116341.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341009", "story_v_out_116341.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_116341", "116341009", "story_v_out_116341.awb")

						arg_37_1:RecordAudio("116341009", var_40_8)
						arg_37_1:RecordAudio("116341009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_116341", "116341009", "story_v_out_116341.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_116341", "116341009", "story_v_out_116341.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116341010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 116341010
		arg_41_1.duration_ = 3.6

		local var_41_0 = {
			zh = 3.6,
			ja = 2.5
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play116341011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10032ui_story = arg_41_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).z)
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles = arg_41_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_41_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10032ui_story"].transform.position).z)
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10032ui_story"].transform.localEulerAngles = arg_41_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_44_1 = arg_41_1.actors_["10032ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10032ui_story == nil then
				arg_41_1.var_.characterEffect10032ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10032ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10032ui_story then
				arg_41_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(116341010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)

				if (13 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 13)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341010", "story_v_out_116341.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341010", "story_v_out_116341.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_116341", "116341010", "story_v_out_116341.awb")

						arg_41_1:RecordAudio("116341010", var_44_11)
						arg_41_1:RecordAudio("116341010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_116341", "116341010", "story_v_out_116341.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_116341", "116341010", "story_v_out_116341.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play116341011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 116341011
		arg_45_1.duration_ = 9.93

		local var_45_0 = {
			zh = 6.4,
			ja = 9.933
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play116341012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10032ui_story"]) and arg_45_1.var_.characterEffect10032ui_story == nil then
				arg_45_1.var_.characterEffect10032ui_story = arg_45_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10032ui_story"]) then
				if arg_45_1.var_.characterEffect10032ui_story and not isNil(arg_45_1.actors_["10032ui_story"]) then
					arg_45_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10032ui_story"]) and arg_45_1.var_.characterEffect10032ui_story then
				arg_45_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.75

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(116341011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 30 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 30)

				if (30 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 30)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341011", "story_v_out_116341.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341011", "story_v_out_116341.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_116341", "116341011", "story_v_out_116341.awb")

						arg_45_1:RecordAudio("116341011", var_48_8)
						arg_45_1:RecordAudio("116341011", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_116341", "116341011", "story_v_out_116341.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_116341", "116341011", "story_v_out_116341.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play116341012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 116341012
		arg_49_1.duration_ = 4.23

		local var_49_0 = {
			zh = 4.233,
			ja = 4.2
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play116341013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10032ui_story = arg_49_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).z)
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles = arg_49_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_49_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10032ui_story"].transform.position).z)
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10032ui_story"].transform.localEulerAngles = arg_49_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_52_1 = arg_49_1.actors_["10032ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10032ui_story == nil then
				arg_49_1.var_.characterEffect10032ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10032ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10032ui_story then
				arg_49_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_52_4 = 0
			local var_52_5 = 0.3

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(116341012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)

				if (12 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 12)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341012", "story_v_out_116341.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341012", "story_v_out_116341.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_116341", "116341012", "story_v_out_116341.awb")

						arg_49_1:RecordAudio("116341012", var_52_11)
						arg_49_1:RecordAudio("116341012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_116341", "116341012", "story_v_out_116341.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_116341", "116341012", "story_v_out_116341.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play116341013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 116341013
		arg_53_1.duration_ = 2.4

		local var_53_0 = {
			zh = 2.4,
			ja = 1.833
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play116341014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10032ui_story"]) and arg_53_1.var_.characterEffect10032ui_story == nil then
				arg_53_1.var_.characterEffect10032ui_story = arg_53_1.actors_["10032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10032ui_story"]) then
				if arg_53_1.var_.characterEffect10032ui_story and not isNil(arg_53_1.actors_["10032ui_story"]) then
					arg_53_1.var_.characterEffect10032ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10032ui_story"]) and arg_53_1.var_.characterEffect10032ui_story then
				arg_53_1.var_.characterEffect10032ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10032ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(116341013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 8 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 8)

				if (8 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 8)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341013", "story_v_out_116341.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341013", "story_v_out_116341.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_116341", "116341013", "story_v_out_116341.awb")

						arg_53_1:RecordAudio("116341013", var_56_8)
						arg_53_1:RecordAudio("116341013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_116341", "116341013", "story_v_out_116341.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_116341", "116341013", "story_v_out_116341.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play116341014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 116341014
		arg_57_1.duration_ = 10.27

		local var_57_0 = {
			zh = 6.9,
			ja = 10.266
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play116341015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10032ui_story = arg_57_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).z)
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles = arg_57_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_57_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10032ui_story"].transform.position).z)
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10032ui_story"].transform.localEulerAngles = arg_57_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_60_1 = arg_57_1.actors_["10032ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10032ui_story == nil then
				arg_57_1.var_.characterEffect10032ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10032ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10032ui_story then
				arg_57_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 0.65

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(116341014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 26 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 26)

				if (26 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 26)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341014", "story_v_out_116341.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341014", "story_v_out_116341.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_116341", "116341014", "story_v_out_116341.awb")

						arg_57_1:RecordAudio("116341014", var_60_11)
						arg_57_1:RecordAudio("116341014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_116341", "116341014", "story_v_out_116341.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_116341", "116341014", "story_v_out_116341.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play116341015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 116341015
		arg_61_1.duration_ = 4.67

		local var_61_0 = {
			zh = 3.6,
			ja = 4.666
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play116341016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10032ui_story = arg_61_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).z)
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles = arg_61_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10032ui_story"].transform.position).z)
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10032ui_story"].transform.localEulerAngles = arg_61_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_64_1 = 0
			local var_64_2 = 0.325

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:GetWordFromCfg(116341015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 13 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 13)

				if (13 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 13)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341015", "story_v_out_116341.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341015", "story_v_out_116341.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_116341", "116341015", "story_v_out_116341.awb")

						arg_61_1:RecordAudio("116341015", var_64_8)
						arg_61_1:RecordAudio("116341015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_116341", "116341015", "story_v_out_116341.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_116341", "116341015", "story_v_out_116341.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play116341016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 116341016
		arg_65_1.duration_ = 9

		local var_65_0 = {
			zh = 7.466,
			ja = 9
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play116341017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.775

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(116341016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 31 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 31)

				if (31 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 31)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341016", "story_v_out_116341.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341016", "story_v_out_116341.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_116341", "116341016", "story_v_out_116341.awb")

						arg_65_1:RecordAudio("116341016", var_68_6)
						arg_65_1:RecordAudio("116341016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_116341", "116341016", "story_v_out_116341.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_116341", "116341016", "story_v_out_116341.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play116341017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 116341017
		arg_69_1.duration_ = 12.6

		local var_69_0 = {
			zh = 12.6,
			ja = 10.833
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play116341018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 4 < arg_69_1.time_ and arg_69_1.time_ <= 4 + arg_72_0 then
				local var_72_0 = arg_69_1.bgs_.ST03

				arg_69_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_1 = var_72_0:GetComponent("SpriteRenderer")

				if var_72_1 and var_72_1.sprite then
					local var_72_2 = 2 * (var_72_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_0.transform.localScale = Vector3.New(var_72_2 / var_72_1.sprite.bounds.size.y < var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x and var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x or var_72_2 / var_72_1.sprite.bounds.size.y, var_72_2 / var_72_1.sprite.bounds.size.y < var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x and var_72_2 * manager.ui.mainCameraCom_.aspect / var_72_1.sprite.bounds.size.x or var_72_2 / var_72_1.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST03" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_3 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_4 = 4

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_4 then
				local var_72_5 = Color.New(0, 0, 0)

				var_72_5.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_3) / var_72_4)
				arg_69_1.mask_.color = var_72_5
			end

			if arg_69_1.time_ >= var_72_3 + var_72_4 and arg_69_1.time_ < var_72_3 + var_72_4 + arg_72_0 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = 1
				arg_69_1.mask_.color = var_72_6
			end

			local var_72_7 = 4

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_8 = 4

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 then
				local var_72_9 = Color.New(0, 0, 0)

				var_72_9.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_7) / var_72_8)
				arg_69_1.mask_.color = var_72_9
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 then
				local var_72_10 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_10.a = 0
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_11 = 8
			local var_72_12 = 0.6

			if 8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_13 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_13:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_14 = arg_69_1:GetWordFromCfg(116341017)
				local var_72_15 = arg_69_1:FormatText(var_72_14.content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 24 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_15) / 24)

				if (24 <= 0 and var_72_12 or var_72_12 * (utf8.len(var_72_15) / 24)) > 0 and var_72_12 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17
					var_72_11 = var_72_11 + 0.3

					if var_72_17 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_11
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341017", "story_v_out_116341.awb") ~= 0 then
					local var_72_18 = manager.audio:GetVoiceLength("story_v_out_116341", "116341017", "story_v_out_116341.awb") / 1000

					if var_72_18 + var_72_11 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_18 + var_72_11
					end

					if var_72_14.prefab_name ~= "" and arg_69_1.actors_[var_72_14.prefab_name] ~= nil then
						local var_72_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_14.prefab_name].transform, "story_v_out_116341", "116341017", "story_v_out_116341.awb")

						arg_69_1:RecordAudio("116341017", var_72_19)
						arg_69_1:RecordAudio("116341017", var_72_19)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_116341", "116341017", "story_v_out_116341.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_116341", "116341017", "story_v_out_116341.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_20 = var_72_11 + 0.3
			local var_72_21 = math.max(var_72_12, arg_69_1.talkMaxDuration)

			if var_72_11 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_21 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_21

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_21 and arg_69_1.time_ < var_72_20 + var_72_21 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play116341018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116341018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116341019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116341018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 18 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 18)

				if (18 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 18)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play116341019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116341019
		arg_79_1.duration_ = 6.4

		local var_79_0 = {
			zh = 3.833,
			ja = 6.4
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play116341020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.425

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(116341019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 17 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 17)

				if (17 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 17)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341019", "story_v_out_116341.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341019", "story_v_out_116341.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_116341", "116341019", "story_v_out_116341.awb")

						arg_79_1:RecordAudio("116341019", var_82_6)
						arg_79_1:RecordAudio("116341019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116341", "116341019", "story_v_out_116341.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116341", "116341019", "story_v_out_116341.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play116341020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116341020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116341021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.55

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(116341020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 22 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 22)

				if (22 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 22)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116341021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116341021
		arg_87_1.duration_ = 6.7

		local var_87_0 = {
			zh = 6.7,
			ja = 6.133
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play116341022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.825

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(116341021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 33 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 33)

				if (33 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 33)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341021", "story_v_out_116341.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341021", "story_v_out_116341.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_116341", "116341021", "story_v_out_116341.awb")

						arg_87_1:RecordAudio("116341021", var_90_6)
						arg_87_1:RecordAudio("116341021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116341", "116341021", "story_v_out_116341.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116341", "116341021", "story_v_out_116341.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play116341022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 116341022
		arg_91_1.duration_ = 8.23

		local var_91_0 = {
			zh = 6.433,
			ja = 8.233
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play116341023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(116341022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 30 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 30)

				if (30 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 30)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341022", "story_v_out_116341.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341022", "story_v_out_116341.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_116341", "116341022", "story_v_out_116341.awb")

						arg_91_1:RecordAudio("116341022", var_94_6)
						arg_91_1:RecordAudio("116341022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_116341", "116341022", "story_v_out_116341.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_116341", "116341022", "story_v_out_116341.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play116341023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 116341023
		arg_95_1.duration_ = 3.67

		local var_95_0 = {
			zh = 3.666,
			ja = 3.033
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play116341024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10032ui_story = arg_95_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).z)
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles = arg_95_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_95_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10032ui_story"].transform.position).z)
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10032ui_story"].transform.localEulerAngles = arg_95_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_98_1 = arg_95_1.actors_["10032ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10032ui_story == nil then
				arg_95_1.var_.characterEffect10032ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10032ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10032ui_story then
				arg_95_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_98_4 = 0
			local var_98_5 = 0.375

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(116341023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 15 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 15)

				if (15 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 15)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341023", "story_v_out_116341.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341023", "story_v_out_116341.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_116341", "116341023", "story_v_out_116341.awb")

						arg_95_1:RecordAudio("116341023", var_98_11)
						arg_95_1:RecordAudio("116341023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_116341", "116341023", "story_v_out_116341.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_116341", "116341023", "story_v_out_116341.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play116341024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 116341024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play116341025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10032ui_story = arg_99_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).z)
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles = arg_99_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10032ui_story"].transform.position).z)
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10032ui_story"].transform.localEulerAngles = arg_99_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_102_1 = 0
			local var_102_2 = 0.775

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(116341024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 31 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 31)

				if (31 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 31)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play116341025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 116341025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play116341026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.225

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(116341025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 9 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 9)

				if (9 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 9)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play116341026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 116341026
		arg_107_1.duration_ = 3.9

		local var_107_0 = {
			zh = 3.4,
			ja = 3.9
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play116341027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.325

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:GetWordFromCfg(116341026)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 13 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 13)

				if (13 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 13)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341026", "story_v_out_116341.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341026", "story_v_out_116341.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_116341", "116341026", "story_v_out_116341.awb")

						arg_107_1:RecordAudio("116341026", var_110_6)
						arg_107_1:RecordAudio("116341026", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_116341", "116341026", "story_v_out_116341.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_116341", "116341026", "story_v_out_116341.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play116341027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 116341027
		arg_111_1.duration_ = 6.37

		local var_111_0 = {
			zh = 6.366,
			ja = 5.966
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play116341028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.8

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(116341027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 32 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 32)

				if (32 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 32)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341027", "story_v_out_116341.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341027", "story_v_out_116341.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_116341", "116341027", "story_v_out_116341.awb")

						arg_111_1:RecordAudio("116341027", var_114_6)
						arg_111_1:RecordAudio("116341027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_116341", "116341027", "story_v_out_116341.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_116341", "116341027", "story_v_out_116341.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play116341028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 116341028
		arg_115_1.duration_ = 6.07

		local var_115_0 = {
			zh = 4.2,
			ja = 6.066
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play116341029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.475

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(116341028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 19 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 19)

				if (19 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 19)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341028", "story_v_out_116341.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341028", "story_v_out_116341.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_116341", "116341028", "story_v_out_116341.awb")

						arg_115_1:RecordAudio("116341028", var_118_6)
						arg_115_1:RecordAudio("116341028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_116341", "116341028", "story_v_out_116341.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_116341", "116341028", "story_v_out_116341.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play116341029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 116341029
		arg_119_1.duration_ = 7.5

		local var_119_0 = {
			zh = 5,
			ja = 7.5
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play116341030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10032ui_story = arg_119_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).z)
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles = arg_119_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_119_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10032ui_story"].transform.position).z)
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10032ui_story"].transform.localEulerAngles = arg_119_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action432")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_122_1 = arg_119_1.actors_["10032ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10032ui_story == nil then
				arg_119_1.var_.characterEffect10032ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10032ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10032ui_story then
				arg_119_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			local var_122_4 = 0
			local var_122_5 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(116341029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 14 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 14)

				if (14 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 14)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341029", "story_v_out_116341.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341029", "story_v_out_116341.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_116341", "116341029", "story_v_out_116341.awb")

						arg_119_1:RecordAudio("116341029", var_122_11)
						arg_119_1:RecordAudio("116341029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_116341", "116341029", "story_v_out_116341.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_116341", "116341029", "story_v_out_116341.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play116341030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 116341030
		arg_123_1.duration_ = 8.7

		local var_123_0 = {
			zh = 8.7,
			ja = 8.133
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play116341031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10032ui_story = arg_123_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).z)
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles = arg_123_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10032ui_story"].transform.position).z)
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10032ui_story"].transform.localEulerAngles = arg_123_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_126_1 = 0
			local var_126_2 = 1.15

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:GetWordFromCfg(116341030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 46 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 46)

				if (46 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_4) / 46)) > 0 and var_126_2 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341030", "story_v_out_116341.awb") ~= 0 then
					local var_126_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341030", "story_v_out_116341.awb") / 1000

					if var_126_7 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_1
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_116341", "116341030", "story_v_out_116341.awb")

						arg_123_1:RecordAudio("116341030", var_126_8)
						arg_123_1:RecordAudio("116341030", var_126_8)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_116341", "116341030", "story_v_out_116341.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_116341", "116341030", "story_v_out_116341.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_9 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_9 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_9

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_9 and arg_123_1.time_ < var_126_1 + var_126_9 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play116341031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 116341031
		arg_127_1.duration_ = 11.3

		local var_127_0 = {
			zh = 9.999999999999,
			ja = 11.3
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play116341032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_130_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_127_1.stage_.transform)

				var_130_0.name = "10025ui_story"
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["10025ui_story"] = var_130_0

				local var_130_1 = var_130_0:GetComponentInChildren(typeof(CharacterEffect))

				var_130_1.enabled = true

				local var_130_2 = GameObjectTools.GetOrAddComponent(var_130_0, typeof(DynamicBoneHelper))

				if var_130_2 then
					var_130_2:EnableDynamicBone(false)
				end

				arg_127_1:ShowWeapon(var_130_1.transform, false)

				arg_127_1.var_["10025ui_story" .. "Animator"] = var_130_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_127_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_127_1.var_["10025ui_story" .. "LipSync"] = var_130_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_130_3 = arg_127_1.actors_["10025ui_story"].transform

			if 8 < arg_127_1.time_ and arg_127_1.time_ <= 8 + arg_130_0 then
				arg_127_1.var_.moveOldPos10025ui_story = var_130_3.localPosition
			end

			local var_130_4 = 0.001

			if 8 <= arg_127_1.time_ and arg_127_1.time_ < 8 + var_130_4 then
				var_130_3.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_127_1.time_ - 8) / var_130_4)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if arg_127_1.time_ >= 8 + var_130_4 and arg_127_1.time_ < 8 + var_130_4 + arg_130_0 then
				var_130_3.localPosition = Vector3.New(0, -1.1, -5.9)
				var_130_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_3.position).x, (manager.ui.mainCamera.transform.position - var_130_3.position).y, (manager.ui.mainCamera.transform.position - var_130_3.position).z)
				var_130_3.localEulerAngles.z = 0
				var_130_3.localEulerAngles.x = 0
				var_130_3.localEulerAngles = var_130_3.localEulerAngles
			end

			if 8 < arg_127_1.time_ and arg_127_1.time_ <= 8 + arg_130_0 then
				arg_127_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_130_5 = arg_127_1.actors_["10025ui_story"]

			if 8 < arg_127_1.time_ and arg_127_1.time_ <= 8 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10025ui_story == nil then
				arg_127_1.var_.characterEffect10025ui_story = var_130_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.2

			if 8 <= arg_127_1.time_ and arg_127_1.time_ < 8 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.characterEffect10025ui_story and not isNil(var_130_5) then
					arg_127_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 8 + var_130_6 and arg_127_1.time_ < 8 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.characterEffect10025ui_story then
				arg_127_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 8 < arg_127_1.time_ and arg_127_1.time_ <= 8 + arg_130_0 then
				arg_127_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_130_8 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_9 = 4

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_9 then
				local var_130_10 = Color.New(0, 0, 0)

				var_130_10.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_8) / var_130_9)
				arg_127_1.mask_.color = var_130_10
			end

			if arg_127_1.time_ >= var_130_8 + var_130_9 and arg_127_1.time_ < var_130_8 + var_130_9 + arg_130_0 then
				local var_130_11 = Color.New(0, 0, 0)

				var_130_11.a = 1
				arg_127_1.mask_.color = var_130_11
			end

			local var_130_12 = 4

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_13 = 4

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_13 then
				local var_130_14 = Color.New(0, 0, 0)

				var_130_14.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_12) / var_130_13)
				arg_127_1.mask_.color = var_130_14
			end

			if arg_127_1.time_ >= var_130_12 + var_130_13 and arg_127_1.time_ < var_130_12 + var_130_13 + arg_130_0 then
				local var_130_15 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_15.a = 0
				arg_127_1.mask_.color = var_130_15
			end

			local var_130_16 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_16 + 8.2 and arg_127_1.time_ < var_130_16 + 8.2 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_17 = 8
			local var_130_18 = 0.075

			if 8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_17 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_19 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_19:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_20 = arg_127_1:GetWordFromCfg(116341031)
				local var_130_21 = arg_127_1:FormatText(var_130_20.content)

				arg_127_1.text_.text = var_130_21

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_23 = 3 <= 0 and var_130_18 or var_130_18 * (utf8.len(var_130_21) / 3)

				if (3 <= 0 and var_130_18 or var_130_18 * (utf8.len(var_130_21) / 3)) > 0 and var_130_18 < var_130_23 then
					arg_127_1.talkMaxDuration = var_130_23
					var_130_17 = var_130_17 + 0.3

					if var_130_23 + var_130_17 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_17
					end
				end

				arg_127_1.text_.text = var_130_21
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341031", "story_v_out_116341.awb") ~= 0 then
					local var_130_24 = manager.audio:GetVoiceLength("story_v_out_116341", "116341031", "story_v_out_116341.awb") / 1000

					if var_130_24 + var_130_17 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_24 + var_130_17
					end

					if var_130_20.prefab_name ~= "" and arg_127_1.actors_[var_130_20.prefab_name] ~= nil then
						local var_130_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_20.prefab_name].transform, "story_v_out_116341", "116341031", "story_v_out_116341.awb")

						arg_127_1:RecordAudio("116341031", var_130_25)
						arg_127_1:RecordAudio("116341031", var_130_25)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_116341", "116341031", "story_v_out_116341.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_116341", "116341031", "story_v_out_116341.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_26 = var_130_17 + 0.3
			local var_130_27 = math.max(var_130_18, arg_127_1.talkMaxDuration)

			if var_130_17 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_26 + var_130_27 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_26) / var_130_27

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_26 + var_130_27 and arg_127_1.time_ < var_130_26 + var_130_27 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play116341032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 116341032
		arg_133_1.duration_ = 3.53

		local var_133_0 = {
			zh = 3.033,
			ja = 3.533
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
				arg_133_0:Play116341033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10025ui_story"]) and arg_133_1.var_.characterEffect10025ui_story == nil then
				arg_133_1.var_.characterEffect10025ui_story = arg_133_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10025ui_story"]) then
				if arg_133_1.var_.characterEffect10025ui_story and not isNil(arg_133_1.actors_["10025ui_story"]) then
					arg_133_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10025ui_story"]) and arg_133_1.var_.characterEffect10025ui_story then
				arg_133_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.325

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_3 = arg_133_1:GetWordFromCfg(116341032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 13 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 13)

				if (13 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_4) / 13)) > 0 and var_136_2 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341032", "story_v_out_116341.awb") ~= 0 then
					local var_136_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341032", "story_v_out_116341.awb") / 1000

					if var_136_7 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_1
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_116341", "116341032", "story_v_out_116341.awb")

						arg_133_1:RecordAudio("116341032", var_136_8)
						arg_133_1:RecordAudio("116341032", var_136_8)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_116341", "116341032", "story_v_out_116341.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_116341", "116341032", "story_v_out_116341.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_9 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_9 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_9

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_9 and arg_133_1.time_ < var_136_1 + var_136_9 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play116341033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 116341033
		arg_137_1.duration_ = 4.37

		local var_137_0 = {
			zh = 2.466,
			ja = 4.366
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
				arg_137_0:Play116341034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10025ui_story = arg_137_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).z)
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles = arg_137_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_137_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10025ui_story"].transform.position).z)
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10025ui_story"].transform.localEulerAngles = arg_137_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_140_1 = arg_137_1.actors_["10025ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10025ui_story == nil then
				arg_137_1.var_.characterEffect10025ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10025ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10025ui_story then
				arg_137_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_140_4 = 0
			local var_140_5 = 0.1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(116341033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 4 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 4)

				if (4 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 4)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341033", "story_v_out_116341.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341033", "story_v_out_116341.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_116341", "116341033", "story_v_out_116341.awb")

						arg_137_1:RecordAudio("116341033", var_140_11)
						arg_137_1:RecordAudio("116341033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_116341", "116341033", "story_v_out_116341.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_116341", "116341033", "story_v_out_116341.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play116341034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116341034
		arg_141_1.duration_ = 5.6

		local var_141_0 = {
			zh = 5.6,
			ja = 4.766
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
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116341035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10025ui_story = arg_141_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).z)
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles = arg_141_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10025ui_story"].transform.position).z)
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10025ui_story"].transform.localEulerAngles = arg_141_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_144_1 = 0
			local var_144_2 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(116341034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 18 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 18)

				if (18 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 18)) > 0 and var_144_2 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341034", "story_v_out_116341.awb") ~= 0 then
					local var_144_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341034", "story_v_out_116341.awb") / 1000

					if var_144_7 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_1
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_116341", "116341034", "story_v_out_116341.awb")

						arg_141_1:RecordAudio("116341034", var_144_8)
						arg_141_1:RecordAudio("116341034", var_144_8)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_116341", "116341034", "story_v_out_116341.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_116341", "116341034", "story_v_out_116341.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_9 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_9 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_9

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_9 and arg_141_1.time_ < var_144_1 + var_144_9 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play116341035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116341035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116341036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.225

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(116341035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 9 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 9)

				if (9 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 9)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116341036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116341036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116341037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.8

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(116341036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 32 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 32)

				if (32 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 32)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116341037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116341037
		arg_153_1.duration_ = 4.6

		local var_153_0 = {
			zh = 4.6,
			ja = 4.2
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116341038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_156_0 = 0.6

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				local var_156_1, var_156_2 = math.modf((arg_153_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_156_2 * 0.13, var_156_2 * 0.13, var_156_2 * 0.13) + arg_153_1.var_.shakeOldPos
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				manager.ui.mainCamera.transform.localPosition = arg_153_1.var_.shakeOldPos
			end

			local var_156_3 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_3 + 0.6 and arg_153_1.time_ < var_156_3 + 0.6 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_4 = 0
			local var_156_5 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[342].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_6 = arg_153_1:GetWordFromCfg(116341037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 19 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 19)

				if (19 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 19)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341037", "story_v_out_116341.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341037", "story_v_out_116341.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_116341", "116341037", "story_v_out_116341.awb")

						arg_153_1:RecordAudio("116341037", var_156_11)
						arg_153_1:RecordAudio("116341037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_116341", "116341037", "story_v_out_116341.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_116341", "116341037", "story_v_out_116341.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116341038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116341038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116341039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(116341038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 2 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 2)

				if (2 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 2)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116341039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116341039
		arg_161_1.duration_ = 5.63

		local var_161_0 = {
			zh = 3.566,
			ja = 5.633
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116341040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:GetWordFromCfg(116341039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 13 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 13)

				if (13 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 13)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341039", "story_v_out_116341.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341039", "story_v_out_116341.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_116341", "116341039", "story_v_out_116341.awb")

						arg_161_1:RecordAudio("116341039", var_164_6)
						arg_161_1:RecordAudio("116341039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_116341", "116341039", "story_v_out_116341.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_116341", "116341039", "story_v_out_116341.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116341040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116341040
		arg_165_1.duration_ = 2

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116341041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10025ui_story = arg_165_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).z)
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles = arg_165_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_165_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10025ui_story"].transform.position).z)
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10025ui_story"].transform.localEulerAngles = arg_165_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_168_1 = arg_165_1.actors_["10025ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10025ui_story == nil then
				arg_165_1.var_.characterEffect10025ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect10025ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10025ui_story then
				arg_165_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_168_4 = 0
			local var_168_5 = 0.075

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(116341040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 3 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 3)

				if (3 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 3)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341040", "story_v_out_116341.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341040", "story_v_out_116341.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_116341", "116341040", "story_v_out_116341.awb")

						arg_165_1:RecordAudio("116341040", var_168_11)
						arg_165_1:RecordAudio("116341040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_116341", "116341040", "story_v_out_116341.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_116341", "116341040", "story_v_out_116341.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play116341041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116341041
		arg_169_1.duration_ = 6

		local var_169_0 = {
			zh = 6,
			ja = 5.866
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116341042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10025ui_story = arg_169_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).z)
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles = arg_169_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10025ui_story"].transform.position).z)
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10025ui_story"].transform.localEulerAngles = arg_169_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_172_1 = 0
			local var_172_2 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_3 = arg_169_1:GetWordFromCfg(116341041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 28 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 28)

				if (28 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 28)) > 0 and var_172_2 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341041", "story_v_out_116341.awb") ~= 0 then
					local var_172_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341041", "story_v_out_116341.awb") / 1000

					if var_172_7 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_1
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_116341", "116341041", "story_v_out_116341.awb")

						arg_169_1:RecordAudio("116341041", var_172_8)
						arg_169_1:RecordAudio("116341041", var_172_8)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_116341", "116341041", "story_v_out_116341.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_116341", "116341041", "story_v_out_116341.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_9 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_9 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_9

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_9 and arg_169_1.time_ < var_172_1 + var_172_9 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play116341042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116341042
		arg_173_1.duration_ = 9.87

		local var_173_0 = {
			zh = 6.6,
			ja = 9.866
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116341043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				local var_176_0 = arg_173_1.bgs_.ST03

				arg_173_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_1 = var_176_0:GetComponent("SpriteRenderer")

				if var_176_1 and var_176_1.sprite then
					local var_176_2 = 2 * (var_176_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_0.transform.localScale = Vector3.New(var_176_2 / var_176_1.sprite.bounds.size.y < var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x and var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x or var_176_2 / var_176_1.sprite.bounds.size.y, var_176_2 / var_176_1.sprite.bounds.size.y < var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x and var_176_2 * manager.ui.mainCameraCom_.aspect / var_176_1.sprite.bounds.size.x or var_176_2 / var_176_1.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "ST03" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_3 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_4 = 2

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_4 then
				local var_176_5 = Color.New(0, 0, 0)

				var_176_5.a = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_3) / var_176_4)
				arg_173_1.mask_.color = var_176_5
			end

			if arg_173_1.time_ >= var_176_3 + var_176_4 and arg_173_1.time_ < var_176_3 + var_176_4 + arg_176_0 then
				local var_176_6 = Color.New(0, 0, 0)

				var_176_6.a = 1
				arg_173_1.mask_.color = var_176_6
			end

			local var_176_7 = 2

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_7 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_8 = 2

			if var_176_7 <= arg_173_1.time_ and arg_173_1.time_ < var_176_7 + var_176_8 then
				local var_176_9 = Color.New(0, 0, 0)

				var_176_9.a = Mathf.Lerp(1, 0, (arg_173_1.time_ - var_176_7) / var_176_8)
				arg_173_1.mask_.color = var_176_9
			end

			if arg_173_1.time_ >= var_176_7 + var_176_8 and arg_173_1.time_ < var_176_7 + var_176_8 + arg_176_0 then
				local var_176_10 = Color.New(0, 0, 0)

				arg_173_1.mask_.enabled = false
				var_176_10.a = 0
				arg_173_1.mask_.color = var_176_10
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_12 = 4
			local var_176_13 = 0.325

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_14 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_14:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, true)
				arg_173_1.iconController_:SetSelectedState("hero")

				arg_173_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_173_1.callingController_:SetSelectedState("normal")

				arg_173_1.keyicon_.color = Color.New(1, 1, 1)
				arg_173_1.icon_.color = Color.New(1, 1, 1)

				local var_176_15 = arg_173_1:GetWordFromCfg(116341042)
				local var_176_16 = arg_173_1:FormatText(var_176_15.content)

				arg_173_1.text_.text = var_176_16

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_18 = 13 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_16) / 13)

				if (13 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_16) / 13)) > 0 and var_176_13 < var_176_18 then
					arg_173_1.talkMaxDuration = var_176_18
					var_176_12 = var_176_12 + 0.3

					if var_176_18 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_16
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341042", "story_v_out_116341.awb") ~= 0 then
					local var_176_19 = manager.audio:GetVoiceLength("story_v_out_116341", "116341042", "story_v_out_116341.awb") / 1000

					if var_176_19 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_19 + var_176_12
					end

					if var_176_15.prefab_name ~= "" and arg_173_1.actors_[var_176_15.prefab_name] ~= nil then
						local var_176_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_15.prefab_name].transform, "story_v_out_116341", "116341042", "story_v_out_116341.awb")

						arg_173_1:RecordAudio("116341042", var_176_20)
						arg_173_1:RecordAudio("116341042", var_176_20)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_116341", "116341042", "story_v_out_116341.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_116341", "116341042", "story_v_out_116341.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_21 = var_176_12 + 0.3
			local var_176_22 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 + 0.3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_21) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play116341043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 116341043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play116341044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.775

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(116341043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)

				if (31 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 31)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play116341044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 116341044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play116341045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.9

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(116341044).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 36 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 36)

				if (36 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 36)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play116341045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 116341045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play116341046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.7

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(116341045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 28 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 28)

				if (28 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 28)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play116341046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 116341046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play116341047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.975

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(116341046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 39 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 39)

				if (39 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 39)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play116341047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 116341047
		arg_195_1.duration_ = 4.93

		local var_195_0 = {
			zh = 4.933,
			ja = 4.466
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play116341048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10025ui_story = arg_195_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).z)
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles = arg_195_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_195_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10025ui_story"].transform.position).z)
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10025ui_story"].transform.localEulerAngles = arg_195_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_198_1 = arg_195_1.actors_["10032ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10032ui_story == nil then
				arg_195_1.var_.characterEffect10032ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10032ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10032ui_story then
				arg_195_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_198_4 = 0
			local var_198_5 = 0.35

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(116341047)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 14 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 14)

				if (14 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 14)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341047", "story_v_out_116341.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341047", "story_v_out_116341.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_116341", "116341047", "story_v_out_116341.awb")

						arg_195_1:RecordAudio("116341047", var_198_11)
						arg_195_1:RecordAudio("116341047", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_116341", "116341047", "story_v_out_116341.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_116341", "116341047", "story_v_out_116341.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play116341048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 116341048
		arg_199_1.duration_ = 6.97

		local var_199_0 = {
			zh = 6.966,
			ja = 6.366
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play116341049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10025ui_story = arg_199_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).z)
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles = arg_199_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_199_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10025ui_story"].transform.position).z)
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10025ui_story"].transform.localEulerAngles = arg_199_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_202_1 = 0
			local var_202_2 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(116341048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 29 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 29)

				if (29 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_4) / 29)) > 0 and var_202_2 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341048", "story_v_out_116341.awb") ~= 0 then
					local var_202_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341048", "story_v_out_116341.awb") / 1000

					if var_202_7 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_1
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_116341", "116341048", "story_v_out_116341.awb")

						arg_199_1:RecordAudio("116341048", var_202_8)
						arg_199_1:RecordAudio("116341048", var_202_8)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_116341", "116341048", "story_v_out_116341.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_116341", "116341048", "story_v_out_116341.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_9 and arg_199_1.time_ < var_202_1 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play116341049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 116341049
		arg_203_1.duration_ = 14.8

		local var_203_0 = {
			zh = 8,
			ja = 14.8
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play116341050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10025ui_story"]) and arg_203_1.var_.characterEffect10025ui_story == nil then
				arg_203_1.var_.characterEffect10025ui_story = arg_203_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10025ui_story"]) then
				if arg_203_1.var_.characterEffect10025ui_story and not isNil(arg_203_1.actors_["10025ui_story"]) then
					arg_203_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10025ui_story"]) and arg_203_1.var_.characterEffect10025ui_story then
				arg_203_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(116341049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 26 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 26)

				if (26 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 26)) > 0 and var_206_2 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341049", "story_v_out_116341.awb") ~= 0 then
					local var_206_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341049", "story_v_out_116341.awb") / 1000

					if var_206_7 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_1
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_116341", "116341049", "story_v_out_116341.awb")

						arg_203_1:RecordAudio("116341049", var_206_8)
						arg_203_1:RecordAudio("116341049", var_206_8)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_116341", "116341049", "story_v_out_116341.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_116341", "116341049", "story_v_out_116341.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_9 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_9 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_9

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_9 and arg_203_1.time_ < var_206_1 + var_206_9 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play116341050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116341050
		arg_207_1.duration_ = 4.57

		local var_207_0 = {
			zh = 4.566,
			ja = 4.4
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play116341051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_210_0 = 0
			local var_210_1 = 0.375

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(116341050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 15 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 15)

				if (15 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 15)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341050", "story_v_out_116341.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_out_116341", "116341050", "story_v_out_116341.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_out_116341", "116341050", "story_v_out_116341.awb")

						arg_207_1:RecordAudio("116341050", var_210_7)
						arg_207_1:RecordAudio("116341050", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_116341", "116341050", "story_v_out_116341.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_116341", "116341050", "story_v_out_116341.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116341051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 116341051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play116341052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:AudioAction("play", "effect", "se_story_16", "se_story_16_whistle", "")
			end

			local var_214_1 = arg_211_1.actors_["10025ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10025ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, 100, 0)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = 0
			local var_214_4 = 0.1

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(116341051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 4 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 4)

				if (4 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 4)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play116341052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 116341052
		arg_215_1.duration_ = 2

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play116341053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:AudioAction("play", "effect", "se_story_16", "se_story_16_whoosh02", "")
			end

			local var_218_1 = arg_215_1.actors_["10025ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10025ui_story = var_218_1.localPosition
			end

			local var_218_2 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 then
				var_218_1.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_215_1.time_ - 0) / var_218_2)
				var_218_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_1.position).x, (manager.ui.mainCamera.transform.position - var_218_1.position).y, (manager.ui.mainCamera.transform.position - var_218_1.position).z)
				var_218_1.localEulerAngles.z = 0
				var_218_1.localEulerAngles.x = 0
				var_218_1.localEulerAngles = var_218_1.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 then
				var_218_1.localPosition = Vector3.New(0, -1.1, -5.9)
				var_218_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_1.position).x, (manager.ui.mainCamera.transform.position - var_218_1.position).y, (manager.ui.mainCamera.transform.position - var_218_1.position).z)
				var_218_1.localEulerAngles.z = 0
				var_218_1.localEulerAngles.x = 0
				var_218_1.localEulerAngles = var_218_1.localEulerAngles
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_218_3 = arg_215_1.actors_["10025ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_3) and arg_215_1.var_.characterEffect10025ui_story == nil then
				arg_215_1.var_.characterEffect10025ui_story = var_218_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_4 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 and not isNil(var_218_3) then
				if arg_215_1.var_.characterEffect10025ui_story and not isNil(var_218_3) then
					arg_215_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 and not isNil(var_218_3) and arg_215_1.var_.characterEffect10025ui_story then
				arg_215_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action476")
			end

			local var_218_6 = 0
			local var_218_7 = 0.075

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(116341052)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 3 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 3)

				if (3 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 3)) > 0 and var_218_7 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341052", "story_v_out_116341.awb") ~= 0 then
					local var_218_12 = manager.audio:GetVoiceLength("story_v_out_116341", "116341052", "story_v_out_116341.awb") / 1000

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_out_116341", "116341052", "story_v_out_116341.awb")

						arg_215_1:RecordAudio("116341052", var_218_13)
						arg_215_1:RecordAudio("116341052", var_218_13)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_116341", "116341052", "story_v_out_116341.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_116341", "116341052", "story_v_out_116341.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play116341053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 116341053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play116341054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10025ui_story = arg_219_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).z)
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles = arg_219_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10025ui_story"].transform.position).z)
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10025ui_story"].transform.localEulerAngles = arg_219_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_222_1 = 0
			local var_222_2 = 1.125

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(116341053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 45 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 45)

				if (45 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 45)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play116341054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 116341054
		arg_223_1.duration_ = 3.23

		local var_223_0 = {
			zh = 3.233,
			ja = 1.366
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play116341055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.075

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:GetWordFromCfg(116341054)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 3 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 3)

				if (3 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 3)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341054", "story_v_out_116341.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341054", "story_v_out_116341.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_116341", "116341054", "story_v_out_116341.awb")

						arg_223_1:RecordAudio("116341054", var_226_6)
						arg_223_1:RecordAudio("116341054", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_116341", "116341054", "story_v_out_116341.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_116341", "116341054", "story_v_out_116341.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play116341055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 116341055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play116341056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.25

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(116341055).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 10 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 10)

				if (10 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 10)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play116341056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 116341056
		arg_231_1.duration_ = 4.83

		local var_231_0 = {
			zh = 4.5,
			ja = 4.833
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play116341057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10025ui_story = arg_231_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).z)
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles = arg_231_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_231_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["10025ui_story"].transform.position).z)
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["10025ui_story"].transform.localEulerAngles = arg_231_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_234_1 = arg_231_1.actors_["10025ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10025ui_story == nil then
				arg_231_1.var_.characterEffect10025ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect10025ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect10025ui_story then
				arg_231_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_234_4 = 0
			local var_234_5 = 0.325

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(116341056)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 13 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 13)

				if (13 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 13)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341056", "story_v_out_116341.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341056", "story_v_out_116341.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_116341", "116341056", "story_v_out_116341.awb")

						arg_231_1:RecordAudio("116341056", var_234_11)
						arg_231_1:RecordAudio("116341056", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_116341", "116341056", "story_v_out_116341.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_116341", "116341056", "story_v_out_116341.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play116341057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 116341057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play116341058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10025ui_story"]) and arg_235_1.var_.characterEffect10025ui_story == nil then
				arg_235_1.var_.characterEffect10025ui_story = arg_235_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10025ui_story"]) then
				if arg_235_1.var_.characterEffect10025ui_story and not isNil(arg_235_1.actors_["10025ui_story"]) then
					arg_235_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10025ui_story"]) and arg_235_1.var_.characterEffect10025ui_story then
				arg_235_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.4

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(116341057).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 16 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 16)

				if (16 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 16)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play116341058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 116341058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play116341059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.375

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(116341058).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 15 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 15)

				if (15 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 15)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play116341059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 116341059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play116341060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_246_0 = 0
			local var_246_1 = 0.425

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_2 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(116341059).content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 17 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_2) / 17)

				if (17 <= 0 and var_246_1 or var_246_1 * (utf8.len(var_246_2) / 17)) > 0 and var_246_1 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_5 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_5 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_5

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_5 and arg_243_1.time_ < var_246_0 + var_246_5 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play116341060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 116341060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play116341061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(116341060).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 22 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 22)

				if (22 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 22)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play116341061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 116341061
		arg_251_1.duration_ = 7.1

		local var_251_0 = {
			zh = 4.666,
			ja = 7.1
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play116341062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10025ui_story = arg_251_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).z)
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles = arg_251_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_251_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10025ui_story"].transform.position).z)
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10025ui_story"].transform.localEulerAngles = arg_251_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_254_1 = arg_251_1.actors_["10025ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10025ui_story == nil then
				arg_251_1.var_.characterEffect10025ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect10025ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10025ui_story then
				arg_251_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_254_4 = 0
			local var_254_5 = 0.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(116341061)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 15 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 15)

				if (15 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 15)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341061", "story_v_out_116341.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341061", "story_v_out_116341.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_out_116341", "116341061", "story_v_out_116341.awb")

						arg_251_1:RecordAudio("116341061", var_254_11)
						arg_251_1:RecordAudio("116341061", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_116341", "116341061", "story_v_out_116341.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_116341", "116341061", "story_v_out_116341.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play116341062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 116341062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play116341063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10025ui_story"]) and arg_255_1.var_.characterEffect10025ui_story == nil then
				arg_255_1.var_.characterEffect10025ui_story = arg_255_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10025ui_story"]) then
				if arg_255_1.var_.characterEffect10025ui_story and not isNil(arg_255_1.actors_["10025ui_story"]) then
					arg_255_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10025ui_story"]) and arg_255_1.var_.characterEffect10025ui_story then
				arg_255_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_258_1 = 0
			local var_258_2 = 0.825

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_3 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(116341062).content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 33 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 33)

				if (33 <= 0 and var_258_2 or var_258_2 * (utf8.len(var_258_3) / 33)) > 0 and var_258_2 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_6 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_6 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_6

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_6 and arg_255_1.time_ < var_258_1 + var_258_6 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play116341063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 116341063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play116341064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10025ui_story = arg_259_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).z)
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles = arg_259_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10025ui_story"].transform.position).z)
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10025ui_story"].transform.localEulerAngles = arg_259_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_262_1 = 0
			local var_262_2 = 0.275

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(116341063).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 11 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 11)

				if (11 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 11)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play116341064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 116341064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play116341065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(116341064).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 10 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 10)

				if (10 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 10)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play116341065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 116341065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play116341066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.7

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(116341065).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 28 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 28)

				if (28 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 28)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play116341066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 116341066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play116341067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.5

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(116341066).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 20 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 20)

				if (20 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 20)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play116341067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 116341067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play116341068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.45

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(116341067).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 18 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 18)

				if (18 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 18)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play116341068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 116341068
		arg_279_1.duration_ = 4.67

		local var_279_0 = {
			zh = 4.666,
			ja = 4.5
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play116341069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos10025ui_story = arg_279_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).z)
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles = arg_279_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_279_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["10025ui_story"].transform.position).z)
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["10025ui_story"].transform.localEulerAngles = arg_279_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_282_1 = arg_279_1.actors_["10025ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10025ui_story == nil then
				arg_279_1.var_.characterEffect10025ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect10025ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect10025ui_story then
				arg_279_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_282_4 = 0
			local var_282_5 = 0.425

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(116341068)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 17 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 17)

				if (17 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 17)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341068", "story_v_out_116341.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341068", "story_v_out_116341.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_116341", "116341068", "story_v_out_116341.awb")

						arg_279_1:RecordAudio("116341068", var_282_11)
						arg_279_1:RecordAudio("116341068", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_116341", "116341068", "story_v_out_116341.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_116341", "116341068", "story_v_out_116341.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play116341069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 116341069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play116341070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["10025ui_story"]) and arg_283_1.var_.characterEffect10025ui_story == nil then
				arg_283_1.var_.characterEffect10025ui_story = arg_283_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["10025ui_story"]) then
				if arg_283_1.var_.characterEffect10025ui_story and not isNil(arg_283_1.actors_["10025ui_story"]) then
					arg_283_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["10025ui_story"]) and arg_283_1.var_.characterEffect10025ui_story then
				arg_283_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.675

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(116341069).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 27 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 27)

				if (27 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 27)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play116341070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 116341070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play116341071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.425

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(116341070).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 17 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 17)

				if (17 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 17)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play116341071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 116341071
		arg_291_1.duration_ = 7.3

		local var_291_0 = {
			zh = 3.733,
			ja = 7.3
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play116341072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10025ui_story = arg_291_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).z)
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles = arg_291_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_291_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["10025ui_story"].transform.position).z)
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["10025ui_story"].transform.localEulerAngles = arg_291_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_294_1 = arg_291_1.actors_["10025ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10025ui_story == nil then
				arg_291_1.var_.characterEffect10025ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect10025ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect10025ui_story then
				arg_291_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_294_4 = 0
			local var_294_5 = 0.175

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:GetWordFromCfg(116341071)
				local var_294_7 = arg_291_1:FormatText(var_294_6.content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 7 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 7)

				if (7 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_7) / 7)) > 0 and var_294_5 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341071", "story_v_out_116341.awb") ~= 0 then
					local var_294_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341071", "story_v_out_116341.awb") / 1000

					if var_294_10 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_10 + var_294_4
					end

					if var_294_6.prefab_name ~= "" and arg_291_1.actors_[var_294_6.prefab_name] ~= nil then
						local var_294_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_6.prefab_name].transform, "story_v_out_116341", "116341071", "story_v_out_116341.awb")

						arg_291_1:RecordAudio("116341071", var_294_11)
						arg_291_1:RecordAudio("116341071", var_294_11)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_116341", "116341071", "story_v_out_116341.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_116341", "116341071", "story_v_out_116341.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_12 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_12 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_12

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_12 and arg_291_1.time_ < var_294_4 + var_294_12 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play116341072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 116341072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play116341073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10025ui_story"]) and arg_295_1.var_.characterEffect10025ui_story == nil then
				arg_295_1.var_.characterEffect10025ui_story = arg_295_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10025ui_story"]) then
				if arg_295_1.var_.characterEffect10025ui_story and not isNil(arg_295_1.actors_["10025ui_story"]) then
					arg_295_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10025ui_story"]) and arg_295_1.var_.characterEffect10025ui_story then
				arg_295_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 0.975

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(116341072).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 39 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 39)

				if (39 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 39)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play116341073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 116341073
		arg_299_1.duration_ = 5.3

		local var_299_0 = {
			zh = 5.3,
			ja = 4.833
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play116341074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10025ui_story = arg_299_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).z)
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles = arg_299_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_299_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["10025ui_story"].transform.position).z)
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["10025ui_story"].transform.localEulerAngles = arg_299_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_302_1 = arg_299_1.actors_["10025ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10025ui_story == nil then
				arg_299_1.var_.characterEffect10025ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect10025ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect10025ui_story then
				arg_299_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_302_4 = 0
			local var_302_5 = 0.325

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(116341073)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 13 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 13)

				if (13 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 13)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341073", "story_v_out_116341.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341073", "story_v_out_116341.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_116341", "116341073", "story_v_out_116341.awb")

						arg_299_1:RecordAudio("116341073", var_302_11)
						arg_299_1:RecordAudio("116341073", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_116341", "116341073", "story_v_out_116341.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_116341", "116341073", "story_v_out_116341.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play116341074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 116341074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play116341075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["10025ui_story"]) and arg_303_1.var_.characterEffect10025ui_story == nil then
				arg_303_1.var_.characterEffect10025ui_story = arg_303_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["10025ui_story"]) then
				if arg_303_1.var_.characterEffect10025ui_story and not isNil(arg_303_1.actors_["10025ui_story"]) then
					arg_303_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_303_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["10025ui_story"]) and arg_303_1.var_.characterEffect10025ui_story then
				arg_303_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_303_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.7

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(116341074).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 28 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 28)

				if (28 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 28)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play116341075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 116341075
		arg_307_1.duration_ = 3.5

		local var_307_0 = {
			zh = 2.2,
			ja = 3.5
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play116341076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10025ui_story = arg_307_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).z)
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles = arg_307_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_307_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["10025ui_story"].transform.position).z)
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["10025ui_story"].transform.localEulerAngles = arg_307_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_310_1 = arg_307_1.actors_["10025ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10025ui_story == nil then
				arg_307_1.var_.characterEffect10025ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect10025ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect10025ui_story then
				arg_307_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_310_4 = 0
			local var_310_5 = 0.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(116341075)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 5 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 5)

				if (5 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 5)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341075", "story_v_out_116341.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341075", "story_v_out_116341.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_out_116341", "116341075", "story_v_out_116341.awb")

						arg_307_1:RecordAudio("116341075", var_310_11)
						arg_307_1:RecordAudio("116341075", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_116341", "116341075", "story_v_out_116341.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_116341", "116341075", "story_v_out_116341.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play116341076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 116341076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play116341077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10025ui_story"]) and arg_311_1.var_.characterEffect10025ui_story == nil then
				arg_311_1.var_.characterEffect10025ui_story = arg_311_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10025ui_story"]) then
				if arg_311_1.var_.characterEffect10025ui_story and not isNil(arg_311_1.actors_["10025ui_story"]) then
					arg_311_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_311_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_0)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10025ui_story"]) and arg_311_1.var_.characterEffect10025ui_story then
				arg_311_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_311_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_314_1 = 0
			local var_314_2 = 0.9

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(116341076).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 36 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 36)

				if (36 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 36)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play116341077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 116341077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play116341078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.25

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(116341077).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 10 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 10)

				if (10 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 10)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play116341078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 116341078
		arg_319_1.duration_ = 3.27

		local var_319_0 = {
			zh = 3.266,
			ja = 2.866
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play116341079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10025ui_story = arg_319_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).z)
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles = arg_319_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_319_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["10025ui_story"].transform.position).z)
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["10025ui_story"].transform.localEulerAngles = arg_319_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_322_1 = arg_319_1.actors_["10025ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10025ui_story == nil then
				arg_319_1.var_.characterEffect10025ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect10025ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect10025ui_story then
				arg_319_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_322_4 = 0
			local var_322_5 = 0.2

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(116341078)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 8 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 8)

				if (8 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 8)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341078", "story_v_out_116341.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341078", "story_v_out_116341.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_116341", "116341078", "story_v_out_116341.awb")

						arg_319_1:RecordAudio("116341078", var_322_11)
						arg_319_1:RecordAudio("116341078", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_116341", "116341078", "story_v_out_116341.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_116341", "116341078", "story_v_out_116341.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play116341079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 116341079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play116341080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["10025ui_story"]) and arg_323_1.var_.characterEffect10025ui_story == nil then
				arg_323_1.var_.characterEffect10025ui_story = arg_323_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["10025ui_story"]) then
				if arg_323_1.var_.characterEffect10025ui_story and not isNil(arg_323_1.actors_["10025ui_story"]) then
					arg_323_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["10025ui_story"]) and arg_323_1.var_.characterEffect10025ui_story then
				arg_323_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 1.175

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(116341079).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 47 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 47)

				if (47 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 47)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play116341080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 116341080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play116341081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.125

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(116341080).content)

				arg_327_1.text_.text = var_330_1

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_3 = 5 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 5)

				if (5 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_1) / 5)) > 0 and var_330_0 < var_330_3 then
					arg_327_1.talkMaxDuration = var_330_3

					if var_330_3 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_3 + 0
					end
				end

				arg_327_1.text_.text = var_330_1
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_4 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_4

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play116341081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 116341081
		arg_331_1.duration_ = 4.4

		local var_331_0 = {
			zh = 4.4,
			ja = 2.4
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play116341082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10025ui_story = arg_331_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).z)
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles = arg_331_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_331_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["10025ui_story"].transform.position).z)
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["10025ui_story"].transform.localEulerAngles = arg_331_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_334_1 = arg_331_1.actors_["10025ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect10025ui_story == nil then
				arg_331_1.var_.characterEffect10025ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect10025ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect10025ui_story then
				arg_331_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action458")
			end

			local var_334_4 = 0
			local var_334_5 = 0.275

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(116341081)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 11 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 11)

				if (11 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 11)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341081", "story_v_out_116341.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341081", "story_v_out_116341.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_out_116341", "116341081", "story_v_out_116341.awb")

						arg_331_1:RecordAudio("116341081", var_334_11)
						arg_331_1:RecordAudio("116341081", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_116341", "116341081", "story_v_out_116341.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_116341", "116341081", "story_v_out_116341.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play116341082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 116341082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play116341083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["10025ui_story"]) and arg_335_1.var_.characterEffect10025ui_story == nil then
				arg_335_1.var_.characterEffect10025ui_story = arg_335_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["10025ui_story"]) then
				if arg_335_1.var_.characterEffect10025ui_story and not isNil(arg_335_1.actors_["10025ui_story"]) then
					arg_335_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_335_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["10025ui_story"]) and arg_335_1.var_.characterEffect10025ui_story then
				arg_335_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_335_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.475

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(116341082).content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 19 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 19)

				if (19 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_3) / 19)) > 0 and var_338_2 < var_338_5 then
					arg_335_1.talkMaxDuration = var_338_5

					if var_338_5 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_6 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_6 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_6

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_6 and arg_335_1.time_ < var_338_1 + var_338_6 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play116341083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 116341083
		arg_339_1.duration_ = 4.03

		local var_339_0 = {
			zh = 3.6,
			ja = 4.033
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play116341084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10025ui_story = arg_339_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).z)
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles = arg_339_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_339_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10025ui_story"].transform.position).z)
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10025ui_story"].transform.localEulerAngles = arg_339_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_342_1 = arg_339_1.actors_["10025ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10025ui_story == nil then
				arg_339_1.var_.characterEffect10025ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect10025ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10025ui_story then
				arg_339_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action487")
			end

			local var_342_4 = 0
			local var_342_5 = 0.3

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(116341083)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 12 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 12)

				if (12 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 12)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341083", "story_v_out_116341.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341083", "story_v_out_116341.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_116341", "116341083", "story_v_out_116341.awb")

						arg_339_1:RecordAudio("116341083", var_342_11)
						arg_339_1:RecordAudio("116341083", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_116341", "116341083", "story_v_out_116341.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_116341", "116341083", "story_v_out_116341.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play116341084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 116341084
		arg_343_1.duration_ = 4.7

		local var_343_0 = {
			zh = 2.733,
			ja = 4.7
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play116341085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10025ui_story = arg_343_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).z)
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles = arg_343_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10025ui_story"].transform.position).z)
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["10025ui_story"].transform.localEulerAngles = arg_343_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_346_1 = manager.ui.mainCamera.transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.shakeOldPos = var_346_1.localPosition
			end

			local var_346_2 = 0.6

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 then
				local var_346_3, var_346_4 = math.modf((arg_343_1.time_ - 0) / 0.066)

				var_346_1.localPosition = Vector3.New(var_346_4 * 0.13, var_346_4 * 0.13, var_346_4 * 0.13) + arg_343_1.var_.shakeOldPos
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 then
				var_346_1.localPosition = arg_343_1.var_.shakeOldPos
			end

			local var_346_5 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_5 + 0.6 and arg_343_1.time_ < var_346_5 + 0.6 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_346_8 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_8 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_8

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_8
						arg_343_1.bgmTxt2_.text = var_346_8
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_346_9 = 0
			local var_346_10 = 0.375

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_11 = arg_343_1:GetWordFromCfg(116341084)
				local var_346_12 = arg_343_1:FormatText(var_346_11.content)

				arg_343_1.text_.text = var_346_12

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_14 = 15 <= 0 and var_346_10 or var_346_10 * (utf8.len(var_346_12) / 15)

				if (15 <= 0 and var_346_10 or var_346_10 * (utf8.len(var_346_12) / 15)) > 0 and var_346_10 < var_346_14 then
					arg_343_1.talkMaxDuration = var_346_14

					if var_346_14 + var_346_9 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_9
					end
				end

				arg_343_1.text_.text = var_346_12
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341084", "story_v_out_116341.awb") ~= 0 then
					local var_346_15 = manager.audio:GetVoiceLength("story_v_out_116341", "116341084", "story_v_out_116341.awb") / 1000

					if var_346_15 + var_346_9 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_15 + var_346_9
					end

					if var_346_11.prefab_name ~= "" and arg_343_1.actors_[var_346_11.prefab_name] ~= nil then
						local var_346_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_11.prefab_name].transform, "story_v_out_116341", "116341084", "story_v_out_116341.awb")

						arg_343_1:RecordAudio("116341084", var_346_16)
						arg_343_1:RecordAudio("116341084", var_346_16)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_116341", "116341084", "story_v_out_116341.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_116341", "116341084", "story_v_out_116341.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_17 = math.max(var_346_10, arg_343_1.talkMaxDuration)

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_17 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_9) / var_346_17

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_9 + var_346_17 and arg_343_1.time_ < var_346_9 + var_346_17 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play116341085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 116341085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play116341086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.125

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(116341085).content)

				arg_348_1.text_.text = var_351_1

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_3 = 5 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 5)

				if (5 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_1) / 5)) > 0 and var_351_0 < var_351_3 then
					arg_348_1.talkMaxDuration = var_351_3

					if var_351_3 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_3 + 0
					end
				end

				arg_348_1.text_.text = var_351_1
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_4 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_4 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_4

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_4 and arg_348_1.time_ < 0 + var_351_4 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play116341086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 116341086
		arg_352_1.duration_ = 4.6

		local var_352_0 = {
			zh = 4.6,
			ja = 4.5
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play116341087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.5

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_1 = arg_352_1:GetWordFromCfg(116341086)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 20 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 20)

				if (20 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 20)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341086", "story_v_out_116341.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_116341", "116341086", "story_v_out_116341.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_116341", "116341086", "story_v_out_116341.awb")

						arg_352_1:RecordAudio("116341086", var_355_6)
						arg_352_1:RecordAudio("116341086", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_116341", "116341086", "story_v_out_116341.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_116341", "116341086", "story_v_out_116341.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play116341087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 116341087
		arg_356_1.duration_ = 3.8

		local var_356_0 = {
			zh = 3.8,
			ja = 1.999999999999
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play116341088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10025ui_story = arg_356_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).z)
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles = arg_356_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_356_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["10025ui_story"].transform.position).z)
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["10025ui_story"].transform.localEulerAngles = arg_356_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_359_1 = arg_356_1.actors_["10025ui_story"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect10025ui_story == nil then
				arg_356_1.var_.characterEffect10025ui_story = var_359_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_2 = 0.2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_2 and not isNil(var_359_1) then
				if arg_356_1.var_.characterEffect10025ui_story and not isNil(var_359_1) then
					arg_356_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_2 and arg_356_1.time_ < 0 + var_359_2 + arg_359_0 and not isNil(var_359_1) and arg_356_1.var_.characterEffect10025ui_story then
				arg_356_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_359_4 = 0
			local var_359_5 = 0.3

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_6 = arg_356_1:GetWordFromCfg(116341087)
				local var_359_7 = arg_356_1:FormatText(var_359_6.content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_9 = 12 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 12)

				if (12 <= 0 and var_359_5 or var_359_5 * (utf8.len(var_359_7) / 12)) > 0 and var_359_5 < var_359_9 then
					arg_356_1.talkMaxDuration = var_359_9

					if var_359_9 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_9 + var_359_4
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341087", "story_v_out_116341.awb") ~= 0 then
					local var_359_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341087", "story_v_out_116341.awb") / 1000

					if var_359_10 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_4
					end

					if var_359_6.prefab_name ~= "" and arg_356_1.actors_[var_359_6.prefab_name] ~= nil then
						local var_359_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_6.prefab_name].transform, "story_v_out_116341", "116341087", "story_v_out_116341.awb")

						arg_356_1:RecordAudio("116341087", var_359_11)
						arg_356_1:RecordAudio("116341087", var_359_11)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_116341", "116341087", "story_v_out_116341.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_116341", "116341087", "story_v_out_116341.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_12 = math.max(var_359_5, arg_356_1.talkMaxDuration)

			if var_359_4 <= arg_356_1.time_ and arg_356_1.time_ < var_359_4 + var_359_12 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_4) / var_359_12

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_4 + var_359_12 and arg_356_1.time_ < var_359_4 + var_359_12 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play116341088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 116341088
		arg_360_1.duration_ = 7.47

		local var_360_0 = {
			zh = 5.266,
			ja = 7.466
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play116341089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10025ui_story = arg_360_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).z)
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles = arg_360_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_360_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10025ui_story"].transform.position).z)
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["10025ui_story"].transform.localEulerAngles = arg_360_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_363_1 = arg_360_1.actors_["10025ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect10025ui_story == nil then
				arg_360_1.var_.characterEffect10025ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect10025ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect10025ui_story then
				arg_360_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_363_4 = 0
			local var_363_5 = 0.525

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(116341088)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 21 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 21)

				if (21 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 21)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341088", "story_v_out_116341.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341088", "story_v_out_116341.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_out_116341", "116341088", "story_v_out_116341.awb")

						arg_360_1:RecordAudio("116341088", var_363_11)
						arg_360_1:RecordAudio("116341088", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_116341", "116341088", "story_v_out_116341.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_116341", "116341088", "story_v_out_116341.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_12 = math.max(var_363_5, arg_360_1.talkMaxDuration)

			if var_363_4 <= arg_360_1.time_ and arg_360_1.time_ < var_363_4 + var_363_12 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_4) / var_363_12

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_4 + var_363_12 and arg_360_1.time_ < var_363_4 + var_363_12 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play116341089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 116341089
		arg_364_1.duration_ = 5.73

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play116341090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				local var_367_0 = arg_364_1.bgs_.ST03

				arg_364_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_367_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_367_1 = var_367_0:GetComponent("SpriteRenderer")

				if var_367_1 and var_367_1.sprite then
					local var_367_2 = 2 * (var_367_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_367_0.transform.localScale = Vector3.New(var_367_2 / var_367_1.sprite.bounds.size.y < var_367_2 * manager.ui.mainCameraCom_.aspect / var_367_1.sprite.bounds.size.x and var_367_2 * manager.ui.mainCameraCom_.aspect / var_367_1.sprite.bounds.size.x or var_367_2 / var_367_1.sprite.bounds.size.y, var_367_2 / var_367_1.sprite.bounds.size.y < var_367_2 * manager.ui.mainCameraCom_.aspect / var_367_1.sprite.bounds.size.x and var_367_2 * manager.ui.mainCameraCom_.aspect / var_367_1.sprite.bounds.size.x or var_367_2 / var_367_1.sprite.bounds.size.y, 0)
				end

				for iter_367_0, iter_367_1 in pairs(arg_364_1.bgs_) do
					if iter_367_0 ~= "ST03" then
						iter_367_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			local var_367_4 = arg_364_1.actors_["10025ui_story"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10025ui_story = var_367_4.localPosition
			end

			local var_367_5 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_5 then
				var_367_4.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_5)
				var_367_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_4.position).x, (manager.ui.mainCamera.transform.position - var_367_4.position).y, (manager.ui.mainCamera.transform.position - var_367_4.position).z)
				var_367_4.localEulerAngles.z = 0
				var_367_4.localEulerAngles.x = 0
				var_367_4.localEulerAngles = var_367_4.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_5 and arg_364_1.time_ < 0 + var_367_5 + arg_367_0 then
				var_367_4.localPosition = Vector3.New(0, 100, 0)
				var_367_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_367_4.position).x, (manager.ui.mainCamera.transform.position - var_367_4.position).y, (manager.ui.mainCamera.transform.position - var_367_4.position).z)
				var_367_4.localEulerAngles.z = 0
				var_367_4.localEulerAngles.x = 0
				var_367_4.localEulerAngles = var_367_4.localEulerAngles
			end

			local var_367_6 = 0

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.mask_.enabled = true
				arg_364_1.mask_.raycastTarget = true

				arg_364_1:SetGaussion(false)
			end

			local var_367_7 = 2

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_7 then
				local var_367_8 = Color.New(1, 1, 1)

				var_367_8.a = Mathf.Lerp(1, 0, (arg_364_1.time_ - var_367_6) / var_367_7)
				arg_364_1.mask_.color = var_367_8
			end

			if arg_364_1.time_ >= var_367_6 + var_367_7 and arg_364_1.time_ < var_367_6 + var_367_7 + arg_367_0 then
				local var_367_9 = Color.New(1, 1, 1)

				arg_364_1.mask_.enabled = false
				var_367_9.a = 0
				arg_364_1.mask_.color = var_367_9
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.fswbg_:SetActive(true)
				arg_364_1.dialog_:SetActive(false)

				arg_364_1.fswtw_.percent = 0
				arg_364_1.fswt_.text = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(116341089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.fswt_)

				arg_364_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_364_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_364_1.fswtw_:SetDirty()

				arg_364_1.typewritterCharCountI18N = 0

				SetActive(arg_364_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_364_1:ShowNextGo(false)
			end

			local var_367_10 = 2

			if 2 < arg_364_1.time_ and arg_364_1.time_ <= var_367_10 + arg_367_0 then
				arg_364_1.var_.oldValueTypewriter = arg_364_1.fswtw_.percent

				SetActive(arg_364_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_364_1:ShowNextGo(false)
			end

			local var_367_11 = 56
			local var_367_12 = 3.73333333333333
			local var_367_13, var_367_14 = arg_364_1:GetPercentByPara(arg_364_1:FormatText(arg_364_1:GetWordFromCfg(116341089).content), 3)

			if var_367_10 < arg_364_1.time_ and arg_364_1.time_ <= var_367_10 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0

				local var_367_15 = var_367_11 <= 0 and var_367_12 or var_367_12 * ((var_367_14 - arg_364_1.typewritterCharCountI18N) / var_367_11)

				if (var_367_11 <= 0 and var_367_12 or var_367_12 * ((var_367_14 - arg_364_1.typewritterCharCountI18N) / var_367_11)) > 0 and var_367_12 < var_367_15 then
					arg_364_1.talkMaxDuration = var_367_15

					if var_367_15 + var_367_10 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_15 + var_367_10
					end
				end
			end

			local var_367_16 = math.max(3.73333333333333, arg_364_1.talkMaxDuration)

			if var_367_10 <= arg_364_1.time_ and arg_364_1.time_ < var_367_10 + var_367_16 then
				arg_364_1.fswtw_.percent = Mathf.Lerp(arg_364_1.var_.oldValueTypewriter, var_367_13, (arg_364_1.time_ - var_367_10) / var_367_16)
				arg_364_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_364_1.fswtw_:SetDirty()
			end

			if arg_364_1.time_ >= var_367_10 + var_367_16 and arg_364_1.time_ < var_367_10 + var_367_16 + arg_367_0 then
				arg_364_1.fswtw_.percent = var_367_13

				arg_364_1.fswtw_:SetDirty()
				arg_364_1:ShowNextGo(true)

				arg_364_1.typewritterCharCountI18N = var_367_14
			end

			if 2 < arg_364_1.time_ and arg_364_1.time_ <= 2 + arg_367_0 then
				local var_367_17 = arg_364_1.fswbg_.transform:Find("textbox/adapt/content") or arg_364_1.fswbg_.transform:Find("textbox/content")
				local var_367_18 = arg_364_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_367_19 = var_367_17:GetComponent("RectTransform")

				var_367_17:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_367_19.offsetMin = Vector2.New(0, 0)
				var_367_19.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				local var_367_20 = arg_364_1.bgs_.ST03:GetComponent("SpriteRenderer")

				if var_367_20 then
					arg_364_1.var_.alphaOldValueST03 = var_367_20.color.a
					arg_364_1.var_.alphaMatValueST03 = var_367_20
				end
			end

			local var_367_21 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_21 then
				if arg_364_1.var_.alphaMatValueST03 then
					arg_364_1.var_.alphaMatValueST03.color.a = Mathf.Lerp(arg_364_1.var_.alphaOldValueST03, 5, (arg_364_1.time_ - 0) / var_367_21)
					arg_364_1.var_.alphaMatValueST03.color = arg_364_1.var_.alphaMatValueST03.color
				end
			end

			if arg_364_1.time_ >= 0 + var_367_21 and arg_364_1.time_ < 0 + var_367_21 + arg_367_0 and arg_364_1.var_.alphaMatValueST03 then
				arg_364_1.var_.alphaMatValueST03.color.a = 5
				arg_364_1.var_.alphaMatValueST03.color = arg_364_1.var_.alphaMatValueST03.color
			end

			local var_367_22 = 2

			if 2 < arg_364_1.time_ and arg_364_1.time_ <= var_367_22 + arg_367_0 then
				arg_364_1.allBtn_.enabled = false
			end

			if arg_364_1.time_ >= var_367_22 + 1.16666666666667 and arg_364_1.time_ < var_367_22 + 1.16666666666667 + arg_367_0 then
				arg_364_1.allBtn_.enabled = true
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play116341090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116341090
		arg_368_1.duration_ = 11.08

		local var_368_0 = {
			zh = 11.0833336666667,
			ja = 10.7163336666667
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116341091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if arg_368_1.bgs_.I07a == nil then
				local var_371_0 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07a")
				var_371_0.name = "I07a"
				var_371_0.transform.parent = arg_368_1.stage_.transform
				var_371_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_.I07a = var_371_0
			end

			if 5.63333333333333 < arg_368_1.time_ and arg_368_1.time_ <= 5.63333333333333 + arg_371_0 then
				local var_371_1 = arg_368_1.bgs_.I07a

				arg_368_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_371_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_2 = var_371_1:GetComponent("SpriteRenderer")

				if var_371_2 and var_371_2.sprite then
					local var_371_3 = 2 * (var_371_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_371_1.transform.localScale = Vector3.New(var_371_3 / var_371_2.sprite.bounds.size.y < var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x and var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x or var_371_3 / var_371_2.sprite.bounds.size.y, var_371_3 / var_371_2.sprite.bounds.size.y < var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x and var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x or var_371_3 / var_371_2.sprite.bounds.size.y, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "I07a" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_4 = 0

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_5 = 2

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_5 then
				local var_371_6 = Color.New(0, 0, 0)

				var_371_6.a = Mathf.Lerp(0, 1, (arg_368_1.time_ - var_371_4) / var_371_5)
				arg_368_1.mask_.color = var_371_6
			end

			if arg_368_1.time_ >= var_371_4 + var_371_5 and arg_368_1.time_ < var_371_4 + var_371_5 + arg_371_0 then
				local var_371_7 = Color.New(0, 0, 0)

				var_371_7.a = 1
				arg_368_1.mask_.color = var_371_7
			end

			local var_371_8 = 2

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_9 = 0.0333333333333334

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_9 then
				local var_371_10 = Color.New(0, 0, 0)

				var_371_10.a = Mathf.Lerp(1, 0, (arg_368_1.time_ - var_371_8) / var_371_9)
				arg_368_1.mask_.color = var_371_10
			end

			if arg_368_1.time_ >= var_371_8 + var_371_9 and arg_368_1.time_ < var_371_8 + var_371_9 + arg_371_0 then
				local var_371_11 = Color.New(0, 0, 0)

				arg_368_1.mask_.enabled = false
				var_371_11.a = 0
				arg_368_1.mask_.color = var_371_11
			end

			local var_371_12 = 5.68333366666667

			if 5.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= var_371_12 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_13 = 2

			if var_371_12 <= arg_368_1.time_ and arg_368_1.time_ < var_371_12 + var_371_13 then
				local var_371_14 = Color.New(0, 0, 0)

				var_371_14.a = Mathf.Lerp(1, 0, (arg_368_1.time_ - var_371_12) / var_371_13)
				arg_368_1.mask_.color = var_371_14
			end

			if arg_368_1.time_ >= var_371_12 + var_371_13 and arg_368_1.time_ < var_371_12 + var_371_13 + arg_371_0 then
				local var_371_15 = Color.New(0, 0, 0)

				arg_368_1.mask_.enabled = false
				var_371_15.a = 0
				arg_368_1.mask_.color = var_371_15
			end

			local var_371_16 = 2

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_16 + arg_371_0 then
				SetActive(arg_368_1.dialog_, false)
				SetActive(arg_368_1.allBtn_.gameObject, false)
				arg_368_1.hideBtnsController_:SetSelectedIndex(1)
				manager.video:Play("SofdecAsset/story/story_101161201.usm", function(arg_372_0)
					arg_368_1.time_ = var_371_16 + 3.65666700022352

					if arg_368_1.state_ == "pause" then
						arg_368_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_373_0)
					arg_368_1.state_ = arg_373_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_371_17 = 3.666667

			if var_371_16 <= arg_368_1.time_ and arg_368_1.time_ < var_371_16 + var_371_17 then
				-- block empty
			end

			if arg_368_1.time_ >= var_371_16 + var_371_17 and arg_368_1.time_ < var_371_16 + var_371_17 + arg_371_0 then
				-- block empty
			end

			local var_371_18 = 5.666667

			if 5.666667 < arg_368_1.time_ and arg_368_1.time_ <= var_371_18 + arg_371_0 then
				SetActive(arg_368_1.dialog_, false)
				SetActive(arg_368_1.allBtn_.gameObject, true)
				arg_368_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_368_1.isInLoopVideo = false
			end

			local var_371_19 = 0.0166666666666667

			if var_371_18 <= arg_368_1.time_ and arg_368_1.time_ < var_371_18 + var_371_19 then
				-- block empty
			end

			if arg_368_1.time_ >= var_371_18 + var_371_19 and arg_368_1.time_ < var_371_18 + var_371_19 + arg_371_0 then
				-- block empty
			end

			local var_371_20 = arg_368_1.actors_["10032ui_story"].transform

			if 7.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= 7.68333366666667 + arg_371_0 then
				arg_368_1.var_.moveOldPos10032ui_story = var_371_20.localPosition
			end

			local var_371_21 = 0.001

			if 7.68333366666667 <= arg_368_1.time_ and arg_368_1.time_ < 7.68333366666667 + var_371_21 then
				var_371_20.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_368_1.time_ - 7.68333366666667) / var_371_21)
				var_371_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_20.position).x, (manager.ui.mainCamera.transform.position - var_371_20.position).y, (manager.ui.mainCamera.transform.position - var_371_20.position).z)
				var_371_20.localEulerAngles.z = 0
				var_371_20.localEulerAngles.x = 0
				var_371_20.localEulerAngles = var_371_20.localEulerAngles
			end

			if arg_368_1.time_ >= 7.68333366666667 + var_371_21 and arg_368_1.time_ < 7.68333366666667 + var_371_21 + arg_371_0 then
				var_371_20.localPosition = Vector3.New(0, -1.1, -5.9)
				var_371_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_371_20.position).x, (manager.ui.mainCamera.transform.position - var_371_20.position).y, (manager.ui.mainCamera.transform.position - var_371_20.position).z)
				var_371_20.localEulerAngles.z = 0
				var_371_20.localEulerAngles.x = 0
				var_371_20.localEulerAngles = var_371_20.localEulerAngles
			end

			if 7.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= 7.68333366666667 + arg_371_0 then
				arg_368_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_371_22 = arg_368_1.actors_["10025ui_story"]

			if 7.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= 7.68333366666667 + arg_371_0 and not isNil(var_371_22) and arg_368_1.var_.characterEffect10025ui_story == nil then
				arg_368_1.var_.characterEffect10025ui_story = var_371_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_23 = 0.2

			if 7.68333366666667 <= arg_368_1.time_ and arg_368_1.time_ < 7.68333366666667 + var_371_23 and not isNil(var_371_22) then
				if arg_368_1.var_.characterEffect10025ui_story and not isNil(var_371_22) then
					arg_368_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 7.68333366666667 + var_371_23 and arg_368_1.time_ < 7.68333366666667 + var_371_23 + arg_371_0 and not isNil(var_371_22) and arg_368_1.var_.characterEffect10025ui_story then
				arg_368_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 7.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= 7.68333366666667 + arg_371_0 then
				arg_368_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action2_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.fswbg_:SetActive(false)
				arg_368_1.dialog_:SetActive(false)
				SetActive(arg_368_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_368_1:ShowNextGo(false)
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_25 = 7.68333366666667
			local var_371_26 = 0.225

			if 7.68333366666667 < arg_368_1.time_ and arg_368_1.time_ <= var_371_25 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_27 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_27:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_368_1.dialogCg_.alpha = arg_374_0
				end))
				var_371_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_28 = arg_368_1:GetWordFromCfg(116341090)
				local var_371_29 = arg_368_1:FormatText(var_371_28.content)

				arg_368_1.text_.text = var_371_29

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_31 = 9 <= 0 and var_371_26 or var_371_26 * (utf8.len(var_371_29) / 9)

				if (9 <= 0 and var_371_26 or var_371_26 * (utf8.len(var_371_29) / 9)) > 0 and var_371_26 < var_371_31 then
					arg_368_1.talkMaxDuration = var_371_31
					var_371_25 = var_371_25 + 0.3

					if var_371_31 + var_371_25 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_31 + var_371_25
					end
				end

				arg_368_1.text_.text = var_371_29
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341090", "story_v_out_116341.awb") ~= 0 then
					local var_371_32 = manager.audio:GetVoiceLength("story_v_out_116341", "116341090", "story_v_out_116341.awb") / 1000

					if var_371_32 + var_371_25 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_32 + var_371_25
					end

					if var_371_28.prefab_name ~= "" and arg_368_1.actors_[var_371_28.prefab_name] ~= nil then
						local var_371_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_28.prefab_name].transform, "story_v_out_116341", "116341090", "story_v_out_116341.awb")

						arg_368_1:RecordAudio("116341090", var_371_33)
						arg_368_1:RecordAudio("116341090", var_371_33)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_116341", "116341090", "story_v_out_116341.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_116341", "116341090", "story_v_out_116341.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_34 = var_371_25 + 0.3
			local var_371_35 = math.max(var_371_26, arg_368_1.talkMaxDuration)

			if var_371_25 + 0.3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_34 + var_371_35 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_34) / var_371_35

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_34 + var_371_35 and arg_368_1.time_ < var_371_34 + var_371_35 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 7.68333366666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play116341091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 116341091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play116341092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos10032ui_story = arg_376_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_379_0 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				arg_376_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos10032ui_story, Vector3.New(0, 100, 0), (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).z)
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles = arg_376_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				arg_376_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_376_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_376_1.actors_["10032ui_story"].transform.position).z)
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_376_1.actors_["10032ui_story"].transform.localEulerAngles = arg_376_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			local var_379_1 = 0
			local var_379_2 = 0.9

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_3 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(116341091).content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_5 = 36 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 36)

				if (36 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_3) / 36)) > 0 and var_379_2 < var_379_5 then
					arg_376_1.talkMaxDuration = var_379_5

					if var_379_5 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_6 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_6 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_6

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_6 and arg_376_1.time_ < var_379_1 + var_379_6 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play116341092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 116341092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play116341093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.4

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(116341092).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 16 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 16)

				if (16 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 16)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play116341093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 116341093
		arg_384_1.duration_ = 8.47

		local var_384_0 = {
			zh = 5.233,
			ja = 8.466
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play116341094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos10032ui_story = arg_384_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).z)
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles = arg_384_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_384_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["10032ui_story"].transform.position).z)
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["10032ui_story"].transform.localEulerAngles = arg_384_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_387_1 = arg_384_1.actors_["10032ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect10032ui_story == nil then
				arg_384_1.var_.characterEffect10032ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect10032ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect10032ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect10032ui_story then
				arg_384_1.var_.characterEffect10032ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_387_4 = 0
			local var_387_5 = 0.525

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(116341093)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 21 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 21)

				if (21 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 21)) > 0 and var_387_5 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341093", "story_v_out_116341.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_out_116341", "116341093", "story_v_out_116341.awb") / 1000

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end

					if var_387_6.prefab_name ~= "" and arg_384_1.actors_[var_387_6.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_6.prefab_name].transform, "story_v_out_116341", "116341093", "story_v_out_116341.awb")

						arg_384_1:RecordAudio("116341093", var_387_11)
						arg_384_1:RecordAudio("116341093", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_116341", "116341093", "story_v_out_116341.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_116341", "116341093", "story_v_out_116341.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_12 and arg_384_1.time_ < var_387_4 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play116341094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 116341094
		arg_388_1.duration_ = 6.2

		local var_388_0 = {
			zh = 6.2,
			ja = 4.1
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play116341095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10032ui_story = arg_388_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).z)
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles = arg_388_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_388_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10032ui_story"].transform.position).z)
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10032ui_story"].transform.localEulerAngles = arg_388_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action443")
			end

			local var_391_1 = 0
			local var_391_2 = 0.525

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_3 = arg_388_1:GetWordFromCfg(116341094)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_6 = 21 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 21)

				if (21 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 21)) > 0 and var_391_2 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341094", "story_v_out_116341.awb") ~= 0 then
					local var_391_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341094", "story_v_out_116341.awb") / 1000

					if var_391_7 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_1
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_116341", "116341094", "story_v_out_116341.awb")

						arg_388_1:RecordAudio("116341094", var_391_8)
						arg_388_1:RecordAudio("116341094", var_391_8)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_116341", "116341094", "story_v_out_116341.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_116341", "116341094", "story_v_out_116341.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_9 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_9 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_9

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_9 and arg_388_1.time_ < var_391_1 + var_391_9 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play116341095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 116341095
		arg_392_1.duration_ = 4.17

		local var_392_0 = {
			zh = 3.733,
			ja = 4.166
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
			arg_392_1.auto_ = false
		end

		function arg_392_1.playNext_(arg_394_0)
			arg_392_1.onStoryFinished_()
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10032ui_story = arg_392_1.actors_["10032ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["10032ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10032ui_story, Vector3.New(0, -1.1, -5.9), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).z)
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles = arg_392_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["10032ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_392_1.actors_["10032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10032ui_story"].transform.position).z)
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["10032ui_story"].transform.localEulerAngles = arg_392_1.actors_["10032ui_story"].transform.localEulerAngles
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("10032ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action438")
			end

			local var_395_1 = 0
			local var_395_2 = 0.225

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_3 = arg_392_1:GetWordFromCfg(116341095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_6 = 9 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 9)

				if (9 <= 0 and var_395_2 or var_395_2 * (utf8.len(var_395_4) / 9)) > 0 and var_395_2 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_1
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116341", "116341095", "story_v_out_116341.awb") ~= 0 then
					local var_395_7 = manager.audio:GetVoiceLength("story_v_out_116341", "116341095", "story_v_out_116341.awb") / 1000

					if var_395_7 + var_395_1 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_1
					end

					if var_395_3.prefab_name ~= "" and arg_392_1.actors_[var_395_3.prefab_name] ~= nil then
						local var_395_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_3.prefab_name].transform, "story_v_out_116341", "116341095", "story_v_out_116341.awb")

						arg_392_1:RecordAudio("116341095", var_395_8)
						arg_392_1:RecordAudio("116341095", var_395_8)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_116341", "116341095", "story_v_out_116341.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_116341", "116341095", "story_v_out_116341.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_9 = math.max(var_395_2, arg_392_1.talkMaxDuration)

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_9 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_1) / var_395_9

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_1 + var_395_9 and arg_392_1.time_ < var_395_1 + var_395_9 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/I07a",
		"SofdecAsset/story/story_101161201.usm"
	},
	voices = {
		"story_v_out_116341.awb"
	}
}
