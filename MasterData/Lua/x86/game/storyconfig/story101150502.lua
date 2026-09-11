return {
	Play115052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115052001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.G03a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G03a")
				var_4_0.name = "G03a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.G03a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.G03a

				arg_1_1.bgs_.G03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "G03a" then
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

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun07", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.65

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115052001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 26 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 26)

				if (26 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 26)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play115052002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115052002
		arg_9_1.duration_ = 3.6

		local var_9_0 = {
			ja = 3.6,
			ko = 3.233,
			zh = 2.966,
			en = 2.966
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
				arg_9_0:Play115052003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(115052002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 14 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 14)

				if (14 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 14)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052002", "story_v_out_115052.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_115052", "115052002", "story_v_out_115052.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_115052", "115052002", "story_v_out_115052.awb")

						arg_9_1:RecordAudio("115052002", var_12_6)
						arg_9_1:RecordAudio("115052002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115052", "115052002", "story_v_out_115052.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115052", "115052002", "story_v_out_115052.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play115052003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115052003
		arg_13_1.duration_ = 7.5

		local var_13_0 = {
			ja = 7.5,
			ko = 2.7,
			zh = 2.533,
			en = 3.233
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115052004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1052ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1052ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1052ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1052ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1052ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1052ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1052ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_16_5 = arg_13_1.actors_["1052ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1052ui_story == nil then
				arg_13_1.var_.characterEffect1052ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1052ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1052ui_story then
				arg_13_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_16_8 = 0
			local var_16_9 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(115052003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 9 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 9)

				if (9 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 9)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052003", "story_v_out_115052.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_115052", "115052003", "story_v_out_115052.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_115052", "115052003", "story_v_out_115052.awb")

						arg_13_1:RecordAudio("115052003", var_16_15)
						arg_13_1:RecordAudio("115052003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115052", "115052003", "story_v_out_115052.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115052", "115052003", "story_v_out_115052.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
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
	Play115052004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115052004
		arg_17_1.duration_ = 4.43

		local var_17_0 = {
			ja = 2.666,
			ko = 3.133,
			zh = 2.933,
			en = 4.433
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115052005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_0 = 0
			local var_20_1 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_2 = arg_17_1:GetWordFromCfg(115052004)
				local var_20_3 = arg_17_1:FormatText(var_20_2.content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 15 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_3) / 15)

				if (15 <= 0 and var_20_1 or var_20_1 * (utf8.len(var_20_3) / 15)) > 0 and var_20_1 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052004", "story_v_out_115052.awb") ~= 0 then
					local var_20_6 = manager.audio:GetVoiceLength("story_v_out_115052", "115052004", "story_v_out_115052.awb") / 1000

					if var_20_6 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_0
					end

					if var_20_2.prefab_name ~= "" and arg_17_1.actors_[var_20_2.prefab_name] ~= nil then
						local var_20_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_2.prefab_name].transform, "story_v_out_115052", "115052004", "story_v_out_115052.awb")

						arg_17_1:RecordAudio("115052004", var_20_7)
						arg_17_1:RecordAudio("115052004", var_20_7)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115052", "115052004", "story_v_out_115052.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115052", "115052004", "story_v_out_115052.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_8 and arg_17_1.time_ < var_20_0 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play115052005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115052005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play115052006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1052ui_story = arg_21_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).z)
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles = arg_21_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1052ui_story"].transform.position).z)
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1052ui_story"].transform.localEulerAngles = arg_21_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_24_1 = 0
			local var_24_2 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(115052005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 21 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 21)

				if (21 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 21)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play115052006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115052006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play115052007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(115052006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 34)

				if (34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 34)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115052007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115052007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			ja = 2.766,
			ko = 1.999999999999,
			zh = 3.9,
			en = 2.3
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
				arg_29_0:Play115052008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1016ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1016ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1016ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1016ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1016ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1016ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1016ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1016ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -18.66, -121.78)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_5 = arg_29_1.actors_["1016ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1016ui_story == nil then
				arg_29_1.var_.characterEffect1016ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1016ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1016ui_story then
				arg_29_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_32_8 = 0
			local var_32_9 = 0.275

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(115052007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)

				if (11 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 11)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052007", "story_v_out_115052.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_115052", "115052007", "story_v_out_115052.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_115052", "115052007", "story_v_out_115052.awb")

						arg_29_1:RecordAudio("115052007", var_32_15)
						arg_29_1:RecordAudio("115052007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115052", "115052007", "story_v_out_115052.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115052", "115052007", "story_v_out_115052.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play115052008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115052008
		arg_33_1.duration_ = 3.97

		local var_33_0 = {
			ja = 2.8,
			ko = 3.966,
			zh = 3.166,
			en = 2.9
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
				arg_33_0:Play115052009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1016ui_story"]) and arg_33_1.var_.characterEffect1016ui_story == nil then
				arg_33_1.var_.characterEffect1016ui_story = arg_33_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1016ui_story"]) then
				if arg_33_1.var_.characterEffect1016ui_story and not isNil(arg_33_1.actors_["1016ui_story"]) then
					arg_33_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1016ui_story"]) and arg_33_1.var_.characterEffect1016ui_story then
				arg_33_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.45

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[275].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(115052008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 18 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 18)

				if (18 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 18)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052008", "story_v_out_115052.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_115052", "115052008", "story_v_out_115052.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_115052", "115052008", "story_v_out_115052.awb")

						arg_33_1:RecordAudio("115052008", var_36_8)
						arg_33_1:RecordAudio("115052008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115052", "115052008", "story_v_out_115052.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115052", "115052008", "story_v_out_115052.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play115052009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115052009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play115052010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(115052009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 50 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 50)

				if (50 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 50)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play115052010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115052010
		arg_41_1.duration_ = 3.93

		local var_41_0 = {
			ja = 3.933,
			ko = 3.4,
			zh = 2.866,
			en = 2.766
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
				arg_41_0:Play115052011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_44_0 = arg_41_1.actors_["1016ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1016ui_story == nil then
				arg_41_1.var_.characterEffect1016ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_1 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 and not isNil(var_44_0) then
				if arg_41_1.var_.characterEffect1016ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1016ui_story then
				arg_41_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			local var_44_3 = 0
			local var_44_4 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(115052010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 12 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 12)

				if (12 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 12)) > 0 and var_44_4 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052010", "story_v_out_115052.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_115052", "115052010", "story_v_out_115052.awb") / 1000

					if var_44_9 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_3
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_115052", "115052010", "story_v_out_115052.awb")

						arg_41_1:RecordAudio("115052010", var_44_10)
						arg_41_1:RecordAudio("115052010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115052", "115052010", "story_v_out_115052.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115052", "115052010", "story_v_out_115052.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_11 and arg_41_1.time_ < var_44_3 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115052011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115052011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115052012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1016ui_story"]) and arg_45_1.var_.characterEffect1016ui_story == nil then
				arg_45_1.var_.characterEffect1016ui_story = arg_45_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1016ui_story"]) then
				if arg_45_1.var_.characterEffect1016ui_story and not isNil(arg_45_1.actors_["1016ui_story"]) then
					arg_45_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1016ui_story"]) and arg_45_1.var_.characterEffect1016ui_story then
				arg_45_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.575

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(115052011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 23 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 23)

				if (23 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 23)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115052012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115052012
		arg_49_1.duration_ = 14.47

		local var_49_0 = {
			ja = 14.466,
			ko = 7.233,
			zh = 7.766,
			en = 6.7
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
				arg_49_0:Play115052013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_0 = arg_49_1.actors_["1016ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1016ui_story == nil then
				arg_49_1.var_.characterEffect1016ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect1016ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1016ui_story then
				arg_49_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_52_3 = 0
			local var_52_4 = 0.725

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(115052012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 29 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 29)

				if (29 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 29)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052012", "story_v_out_115052.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_115052", "115052012", "story_v_out_115052.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_115052", "115052012", "story_v_out_115052.awb")

						arg_49_1:RecordAudio("115052012", var_52_10)
						arg_49_1:RecordAudio("115052012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115052", "115052012", "story_v_out_115052.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115052", "115052012", "story_v_out_115052.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115052013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115052013
		arg_53_1.duration_ = 11.5

		local var_53_0 = {
			ja = 11.5,
			ko = 8.5,
			zh = 9.4,
			en = 7.333
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
				arg_53_0:Play115052014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_0 = 2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				local var_56_1 = Color.New(0, 0, 0)

				var_56_1.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.mask_.color = var_56_1
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				local var_56_2 = Color.New(0, 0, 0)

				var_56_2.a = 1
				arg_53_1.mask_.color = var_56_2
			end

			local var_56_3 = 2

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_4 = 2

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_4 then
				local var_56_5 = Color.New(0, 0, 0)

				var_56_5.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_3) / var_56_4)
				arg_53_1.mask_.color = var_56_5
			end

			if arg_53_1.time_ >= var_56_3 + var_56_4 and arg_53_1.time_ < var_56_3 + var_56_4 + arg_56_0 then
				local var_56_6 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_6.a = 0
				arg_53_1.mask_.color = var_56_6
			end

			local var_56_7 = manager.ui.mainCamera.transform

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= 4 + arg_56_0 then
				arg_53_1.var_.shakeOldPos = var_56_7.localPosition
			end

			local var_56_8 = 0.6

			if 4 <= arg_53_1.time_ and arg_53_1.time_ < 4 + var_56_8 then
				local var_56_9, var_56_10 = math.modf((arg_53_1.time_ - 4) / 0.066)

				var_56_7.localPosition = Vector3.New(var_56_10 * 0.13, var_56_10 * 0.13, var_56_10 * 0.13) + arg_53_1.var_.shakeOldPos
			end

			if arg_53_1.time_ >= 4 + var_56_8 and arg_53_1.time_ < 4 + var_56_8 + arg_56_0 then
				var_56_7.localPosition = arg_53_1.var_.shakeOldPos
			end

			local var_56_11 = 4

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_11 + 0.6 and arg_53_1.time_ < var_56_11 + 0.6 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_12 = arg_53_1.actors_["1016ui_story"].transform

			if 1.966 < arg_53_1.time_ and arg_53_1.time_ <= 1.966 + arg_56_0 then
				arg_53_1.var_.moveOldPos1016ui_story = var_56_12.localPosition
			end

			local var_56_13 = 0.001

			if 1.966 <= arg_53_1.time_ and arg_53_1.time_ < 1.966 + var_56_13 then
				var_56_12.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 1.966) / var_56_13)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			if arg_53_1.time_ >= 1.966 + var_56_13 and arg_53_1.time_ < 1.966 + var_56_13 + arg_56_0 then
				var_56_12.localPosition = Vector3.New(0, 100, 0)
				var_56_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_12.position).x, (manager.ui.mainCamera.transform.position - var_56_12.position).y, (manager.ui.mainCamera.transform.position - var_56_12.position).z)
				var_56_12.localEulerAngles.z = 0
				var_56_12.localEulerAngles.x = 0
				var_56_12.localEulerAngles = var_56_12.localEulerAngles
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_14 = 4
			local var_56_15 = 0.425

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_16 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_16:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_17 = arg_53_1:GetWordFromCfg(115052013)
				local var_56_18 = arg_53_1:FormatText(var_56_17.content)

				arg_53_1.text_.text = var_56_18

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 17 <= 0 and var_56_15 or var_56_15 * (utf8.len(var_56_18) / 17)

				if (17 <= 0 and var_56_15 or var_56_15 * (utf8.len(var_56_18) / 17)) > 0 and var_56_15 < var_56_20 then
					arg_53_1.talkMaxDuration = var_56_20
					var_56_14 = var_56_14 + 0.3

					if var_56_20 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_14
					end
				end

				arg_53_1.text_.text = var_56_18
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052013", "story_v_out_115052.awb") ~= 0 then
					local var_56_21 = manager.audio:GetVoiceLength("story_v_out_115052", "115052013", "story_v_out_115052.awb") / 1000

					if var_56_21 + var_56_14 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_21 + var_56_14
					end

					if var_56_17.prefab_name ~= "" and arg_53_1.actors_[var_56_17.prefab_name] ~= nil then
						local var_56_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_17.prefab_name].transform, "story_v_out_115052", "115052013", "story_v_out_115052.awb")

						arg_53_1:RecordAudio("115052013", var_56_22)
						arg_53_1:RecordAudio("115052013", var_56_22)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115052", "115052013", "story_v_out_115052.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115052", "115052013", "story_v_out_115052.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_23 = var_56_14 + 0.3
			local var_56_24 = math.max(var_56_15, arg_53_1.talkMaxDuration)

			if var_56_14 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_23 + var_56_24 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_23) / var_56_24

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_23 + var_56_24 and arg_53_1.time_ < var_56_23 + var_56_24 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play115052014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 115052014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play115052015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(115052014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 7 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 7)

				if (7 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 7)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play115052015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 115052015
		arg_63_1.duration_ = 7.07

		local var_63_0 = {
			ja = 6.533,
			ko = 7.066,
			zh = 6.566,
			en = 6.5
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play115052016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1052ui_story = arg_63_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).z)
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles = arg_63_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_63_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1052ui_story"].transform.position).z)
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1052ui_story"].transform.localEulerAngles = arg_63_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_1 = arg_63_1.actors_["1052ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1052ui_story == nil then
				arg_63_1.var_.characterEffect1052ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1052ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1052ui_story then
				arg_63_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_66_4 = 0
			local var_66_5 = 0.75

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(115052015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 30 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 30)

				if (30 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 30)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052015", "story_v_out_115052.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_115052", "115052015", "story_v_out_115052.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_115052", "115052015", "story_v_out_115052.awb")

						arg_63_1:RecordAudio("115052015", var_66_11)
						arg_63_1:RecordAudio("115052015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_115052", "115052015", "story_v_out_115052.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_115052", "115052015", "story_v_out_115052.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play115052016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 115052016
		arg_67_1.duration_ = 3.23

		local var_67_0 = {
			ja = 2.5,
			ko = 3.1,
			zh = 2.666,
			en = 3.233
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play115052017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1052ui_story"]) and arg_67_1.var_.characterEffect1052ui_story == nil then
				arg_67_1.var_.characterEffect1052ui_story = arg_67_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1052ui_story"]) then
				if arg_67_1.var_.characterEffect1052ui_story and not isNil(arg_67_1.actors_["1052ui_story"]) then
					arg_67_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1052ui_story"]) and arg_67_1.var_.characterEffect1052ui_story then
				arg_67_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(115052016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 12 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 12)

				if (12 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 12)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052016", "story_v_out_115052.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_115052", "115052016", "story_v_out_115052.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_115052", "115052016", "story_v_out_115052.awb")

						arg_67_1:RecordAudio("115052016", var_70_8)
						arg_67_1:RecordAudio("115052016", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_115052", "115052016", "story_v_out_115052.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_115052", "115052016", "story_v_out_115052.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play115052017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 115052017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play115052018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.8

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(115052017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 32 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 32)

				if (32 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 32)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play115052018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 115052018
		arg_75_1.duration_ = 2.9

		local var_75_0 = {
			ja = 2.4,
			ko = 2.533,
			zh = 2.9,
			en = 2.133
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play115052019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_0 = arg_75_1.actors_["1052ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1052ui_story == nil then
				arg_75_1.var_.characterEffect1052ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_1 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 and not isNil(var_78_0) then
				if arg_75_1.var_.characterEffect1052ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1052ui_story then
				arg_75_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_78_3 = 0
			local var_78_4 = 0.3

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(115052018)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_8 = 12 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 12)

				if (12 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 12)) > 0 and var_78_4 < var_78_8 then
					arg_75_1.talkMaxDuration = var_78_8

					if var_78_8 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052018", "story_v_out_115052.awb") ~= 0 then
					local var_78_9 = manager.audio:GetVoiceLength("story_v_out_115052", "115052018", "story_v_out_115052.awb") / 1000

					if var_78_9 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_3
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_115052", "115052018", "story_v_out_115052.awb")

						arg_75_1:RecordAudio("115052018", var_78_10)
						arg_75_1:RecordAudio("115052018", var_78_10)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_115052", "115052018", "story_v_out_115052.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_115052", "115052018", "story_v_out_115052.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_11 and arg_75_1.time_ < var_78_3 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play115052019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 115052019
		arg_79_1.duration_ = 4.03

		local var_79_0 = {
			ja = 4.033,
			ko = 2.233,
			zh = 2.866,
			en = 3.8
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
				arg_79_0:Play115052020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1052ui_story"]) and arg_79_1.var_.characterEffect1052ui_story == nil then
				arg_79_1.var_.characterEffect1052ui_story = arg_79_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1052ui_story"]) then
				if arg_79_1.var_.characterEffect1052ui_story and not isNil(arg_79_1.actors_["1052ui_story"]) then
					arg_79_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1052ui_story"]) and arg_79_1.var_.characterEffect1052ui_story then
				arg_79_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.225

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(115052019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 9 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_4) / 9)

				if (9 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_4) / 9)) > 0 and var_82_2 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052019", "story_v_out_115052.awb") ~= 0 then
					local var_82_7 = manager.audio:GetVoiceLength("story_v_out_115052", "115052019", "story_v_out_115052.awb") / 1000

					if var_82_7 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_1
					end

					if var_82_3.prefab_name ~= "" and arg_79_1.actors_[var_82_3.prefab_name] ~= nil then
						local var_82_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_3.prefab_name].transform, "story_v_out_115052", "115052019", "story_v_out_115052.awb")

						arg_79_1:RecordAudio("115052019", var_82_8)
						arg_79_1:RecordAudio("115052019", var_82_8)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_115052", "115052019", "story_v_out_115052.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_115052", "115052019", "story_v_out_115052.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_9 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_9 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_9

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_9 and arg_79_1.time_ < var_82_1 + var_82_9 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play115052020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 115052020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play115052021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1052ui_story = arg_83_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).z)
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles = arg_83_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1052ui_story"].transform.position).z)
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1052ui_story"].transform.localEulerAngles = arg_83_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_86_1 = manager.ui.mainCamera.transform

			if 0.7 < arg_83_1.time_ and arg_83_1.time_ <= 0.7 + arg_86_0 then
				arg_83_1.var_.shakeOldPos = var_86_1.localPosition
			end

			local var_86_2 = 1

			if 0.7 <= arg_83_1.time_ and arg_83_1.time_ < 0.7 + var_86_2 then
				local var_86_3, var_86_4 = math.modf((arg_83_1.time_ - 0.7) / 0.066)

				var_86_1.localPosition = Vector3.New(var_86_4 * 0.13, var_86_4 * 0.13, var_86_4 * 0.13) + arg_83_1.var_.shakeOldPos
			end

			if arg_83_1.time_ >= 0.7 + var_86_2 and arg_83_1.time_ < 0.7 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = arg_83_1.var_.shakeOldPos
			end

			local var_86_5 = 0.7

			if 0.7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			if arg_83_1.time_ >= var_86_5 + 1 and arg_83_1.time_ < var_86_5 + 1 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			if 0.7 < arg_83_1.time_ and arg_83_1.time_ <= 0.7 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_15", "se_story_15_shock", "")
			end

			local var_86_7 = 0
			local var_86_8 = 0.625

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_9 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(115052020).content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 25 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_9) / 25)

				if (25 <= 0 and var_86_8 or var_86_8 * (utf8.len(var_86_9) / 25)) > 0 and var_86_8 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_7 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_7
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_12 = math.max(var_86_8, arg_83_1.talkMaxDuration)

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_7) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_7 + var_86_12 and arg_83_1.time_ < var_86_7 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play115052021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 115052021
		arg_87_1.duration_ = 7.5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play115052022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.RO0106 == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0106")
				var_90_0.name = "RO0106"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.RO0106 = var_90_0
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.RO0106

				arg_87_1.bgs_.RO0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "RO0106" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_5 = 2

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_5 then
				local var_90_6 = Color.New(1, 1, 1)

				var_90_6.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_4) / var_90_5)
				arg_87_1.mask_.color = var_90_6
			end

			if arg_87_1.time_ >= var_90_4 + var_90_5 and arg_87_1.time_ < var_90_4 + var_90_5 + arg_90_0 then
				local var_90_7 = Color.New(1, 1, 1)

				arg_87_1.mask_.enabled = false
				var_90_7.a = 0
				arg_87_1.mask_.color = var_90_7
			end

			local var_90_8 = manager.ui.mainCamera.transform

			if 1.33333333333333 < arg_87_1.time_ and arg_87_1.time_ <= 1.33333333333333 + arg_90_0 then
				arg_87_1.var_.shakeOldPos = var_90_8.localPosition
			end

			local var_90_9 = 1.5

			if 1.33333333333333 <= arg_87_1.time_ and arg_87_1.time_ < 1.33333333333333 + var_90_9 then
				local var_90_10, var_90_11 = math.modf((arg_87_1.time_ - 1.33333333333333) / 0.066)

				var_90_8.localPosition = Vector3.New(var_90_11 * 0.13, var_90_11 * 0.13, var_90_11 * 0.13) + arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.time_ >= 1.33333333333333 + var_90_9 and arg_87_1.time_ < 1.33333333333333 + var_90_9 + arg_90_0 then
				var_90_8.localPosition = arg_87_1.var_.shakeOldPos
			end

			local var_90_12 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_12 + 2.025 and arg_87_1.time_ < var_90_12 + 2.025 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_15", "se_story_15_metal", "")
			end

			local var_90_14 = arg_87_1.bgs_.RO0106.transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPosRO0106 = var_90_14.localPosition
			end

			local var_90_15 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_15 then
				var_90_14.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosRO0106, Vector3.New(-1.5, 0.5, 4), (arg_87_1.time_ - 0) / var_90_15)
			end

			if arg_87_1.time_ >= 0 + var_90_15 and arg_87_1.time_ < 0 + var_90_15 + arg_90_0 then
				var_90_14.localPosition = Vector3.New(-1.5, 0.5, 4)
			end

			local var_90_16 = arg_87_1.bgs_.RO0106.transform

			if 0.0166666666666667 < arg_87_1.time_ and arg_87_1.time_ <= 0.0166666666666667 + arg_90_0 then
				arg_87_1.var_.moveOldPosRO0106 = var_90_16.localPosition
			end

			local var_90_17 = 4

			if 0.0166666666666667 <= arg_87_1.time_ and arg_87_1.time_ < 0.0166666666666667 + var_90_17 then
				var_90_16.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPosRO0106, Vector3.New(-1.5, -0.5, 4), (arg_87_1.time_ - 0.0166666666666667) / var_90_17)
			end

			if arg_87_1.time_ >= 0.0166666666666667 + var_90_17 and arg_87_1.time_ < 0.0166666666666667 + var_90_17 + arg_90_0 then
				var_90_16.localPosition = Vector3.New(-1.5, -0.5, 4)
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_18 = 2.5
			local var_90_19 = 1.525

			if 2.5 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_20 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_20:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_21 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(115052021).content)

				arg_87_1.text_.text = var_90_21

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_23 = 61 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_21) / 61)

				if (61 <= 0 and var_90_19 or var_90_19 * (utf8.len(var_90_21) / 61)) > 0 and var_90_19 < var_90_23 then
					arg_87_1.talkMaxDuration = var_90_23
					var_90_18 = var_90_18 + 0.3

					if var_90_23 + var_90_18 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_18
					end
				end

				arg_87_1.text_.text = var_90_21
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_24 = var_90_18 + 0.3
			local var_90_25 = math.max(var_90_19, arg_87_1.talkMaxDuration)

			if var_90_18 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_24 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_24) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_24 + var_90_25 and arg_87_1.time_ < var_90_24 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play115052022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115052022
		arg_93_1.duration_ = 3.3

		local var_93_0 = {
			ja = 3.3,
			ko = 1.9,
			zh = 2.166,
			en = 2.4
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play115052023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.175

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[261].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(115052022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 7 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 7)

				if (7 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 7)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052022", "story_v_out_115052.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_115052", "115052022", "story_v_out_115052.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_115052", "115052022", "story_v_out_115052.awb")

						arg_93_1:RecordAudio("115052022", var_96_6)
						arg_93_1:RecordAudio("115052022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115052", "115052022", "story_v_out_115052.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115052", "115052022", "story_v_out_115052.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115052023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115052023
		arg_97_1.duration_ = 3.1

		local var_97_0 = {
			ja = 3.1,
			ko = 1.366,
			zh = 1.3,
			en = 2.833
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play115052024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(115052023)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 5 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 5)

				if (5 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 5)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052023", "story_v_out_115052.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_115052", "115052023", "story_v_out_115052.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_115052", "115052023", "story_v_out_115052.awb")

						arg_97_1:RecordAudio("115052023", var_100_6)
						arg_97_1:RecordAudio("115052023", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115052", "115052023", "story_v_out_115052.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115052", "115052023", "story_v_out_115052.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play115052024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115052024
		arg_101_1.duration_ = 4.73

		local var_101_0 = {
			ja = 4.733,
			ko = 4.566,
			zh = 3.766,
			en = 3.333
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play115052025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 1.73333333333333 < arg_101_1.time_ and arg_101_1.time_ <= 1.73333333333333 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_104_0 = 1

			if 1.73333333333333 <= arg_101_1.time_ and arg_101_1.time_ < 1.73333333333333 + var_104_0 then
				local var_104_1, var_104_2 = math.modf((arg_101_1.time_ - 1.73333333333333) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_104_2 * 0.13, var_104_2 * 0.13, var_104_2 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= 1.73333333333333 + var_104_0 and arg_101_1.time_ < 1.73333333333333 + var_104_0 + arg_104_0 then
				manager.ui.mainCamera.transform.localPosition = arg_101_1.var_.shakeOldPos
			end

			local var_104_3 = 1.73333333333333

			if 1.73333333333333 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_3 + 0.999999999998666 and arg_101_1.time_ < var_104_3 + 0.999999999998666 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_4 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_5 = 2

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_5 then
				local var_104_6 = Color.New(1, 1, 1)

				var_104_6.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_4) / var_104_5)
				arg_101_1.mask_.color = var_104_6
			end

			if arg_101_1.time_ >= var_104_4 + var_104_5 and arg_101_1.time_ < var_104_4 + var_104_5 + arg_104_0 then
				local var_104_7 = Color.New(1, 1, 1)

				arg_101_1.mask_.enabled = false
				var_104_7.a = 0
				arg_101_1.mask_.color = var_104_7
			end

			local var_104_8 = arg_101_1.bgs_.RO0106.transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPosRO0106 = var_104_8.localPosition
			end

			local var_104_9 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 then
				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPosRO0106, Vector3.New(0, 1, 10), (arg_101_1.time_ - 0) / var_104_9)
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_10 = 2
			local var_104_11 = 0.175

			if 2 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_12 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_12:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_13 = arg_101_1:GetWordFromCfg(115052024)
				local var_104_14 = arg_101_1:FormatText(var_104_13.content)

				arg_101_1.text_.text = var_104_14

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_16 = 7 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_14) / 7)

				if (7 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_14) / 7)) > 0 and var_104_11 < var_104_16 then
					arg_101_1.talkMaxDuration = var_104_16
					var_104_10 = var_104_10 + 0.3

					if var_104_16 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_14
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115052", "115052024", "story_v_out_115052.awb") ~= 0 then
					local var_104_17 = manager.audio:GetVoiceLength("story_v_out_115052", "115052024", "story_v_out_115052.awb") / 1000

					if var_104_17 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_17 + var_104_10
					end

					if var_104_13.prefab_name ~= "" and arg_101_1.actors_[var_104_13.prefab_name] ~= nil then
						local var_104_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_13.prefab_name].transform, "story_v_out_115052", "115052024", "story_v_out_115052.awb")

						arg_101_1:RecordAudio("115052024", var_104_18)
						arg_101_1:RecordAudio("115052024", var_104_18)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115052", "115052024", "story_v_out_115052.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115052", "115052024", "story_v_out_115052.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_19 = var_104_10 + 0.3
			local var_104_20 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_20 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_19) / var_104_20

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_19 + var_104_20 and arg_101_1.time_ < var_104_19 + var_104_20 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0106",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play115052025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 115052025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play115052026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.775

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_2 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_2:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(115052025).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 31 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 31)

				if (31 <= 0 and var_110_1 or var_110_1 * (utf8.len(var_110_3) / 31)) > 0 and var_110_1 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5
					var_110_0 = var_110_0 + 0.3

					if var_110_5 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = var_110_0 + 0.3
			local var_110_7 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 + 0.3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_7 and arg_107_1.time_ < var_110_6 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play115052026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115052026
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
			arg_113_1.auto_ = false
		end

		function arg_113_1.playNext_(arg_115_0)
			arg_113_1.onStoryFinished_()
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.225

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(115052026).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 9 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 9)

				if (9 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 9)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G03a",
		"TextureConfig/Background/RO0106"
	},
	voices = {
		"story_v_out_115052.awb"
	}
}
