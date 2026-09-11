return {
	Play114111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F04 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_4_0.name = "F04"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F04 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F04

				arg_1_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.25

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(114111001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)

				if (10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play114111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114111002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(114111002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)

				if (51 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 51)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play114111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114111003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(114111003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)

				if (52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114111004
		arg_17_1.duration_ = 7.77

		local var_17_0 = {
			ja = 5.866,
			ko = 7.233,
			zh = 7.766,
			en = 5.533
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
				arg_17_0:Play114111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1067ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1067ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1067ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1067ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1067ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1067ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_5 = arg_17_1.actors_["1067ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1067ui_story == nil then
				arg_17_1.var_.characterEffect1067ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1067ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1067ui_story then
				arg_17_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(114111004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 28 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 28)

				if (28 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 28)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111004", "story_v_out_114111.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111004", "story_v_out_114111.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_114111", "114111004", "story_v_out_114111.awb")

						arg_17_1:RecordAudio("114111004", var_20_15)
						arg_17_1:RecordAudio("114111004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114111", "114111004", "story_v_out_114111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114111", "114111004", "story_v_out_114111.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114111005
		arg_21_1.duration_ = 7.13

		local var_21_0 = {
			ja = 7.133,
			ko = 4.566,
			zh = 3.9,
			en = 4.133
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
				arg_21_0:Play114111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1042ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1042ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1042ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1042ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1042ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1042ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_24_5 = arg_21_1.actors_["1042ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1042ui_story == nil then
				arg_21_1.var_.characterEffect1042ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1042ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1042ui_story then
				arg_21_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_24_8 = arg_21_1.actors_["1067ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1067ui_story == nil then
				arg_21_1.var_.characterEffect1067ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect1067ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1067ui_story then
				arg_21_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_24_10 = 0
			local var_24_11 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(114111005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 18 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 18)

				if (18 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 18)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111005", "story_v_out_114111.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_114111", "114111005", "story_v_out_114111.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_114111", "114111005", "story_v_out_114111.awb")

						arg_21_1:RecordAudio("114111005", var_24_17)
						arg_21_1:RecordAudio("114111005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114111", "114111005", "story_v_out_114111.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114111", "114111005", "story_v_out_114111.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play114111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114111006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play114111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1067ui_story = arg_25_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).z)
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles = arg_25_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1067ui_story"].transform.position).z)
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1067ui_story"].transform.localEulerAngles = arg_25_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1042ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1042ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(0, 100, 0)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			local var_28_3 = 0
			local var_28_4 = 0.875

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(114111006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 35 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 35)

				if (35 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 35)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play114111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114111007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play114111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(114111007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 26)

				if (26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 26)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114111008
		arg_33_1.duration_ = 16.63

		local var_33_0 = {
			ja = 16.633,
			ko = 8.7,
			zh = 9.833,
			en = 10.5
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
				arg_33_0:Play114111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1067ui_story = arg_33_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).z)
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles = arg_33_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_33_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1067ui_story"].transform.position).z)
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1067ui_story"].transform.localEulerAngles = arg_33_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1042ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1042ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_3 = arg_33_1.actors_["1067ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1067ui_story == nil then
				arg_33_1.var_.characterEffect1067ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1067ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1067ui_story then
				arg_33_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_36_6 = arg_33_1.actors_["1042ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1042ui_story == nil then
				arg_33_1.var_.characterEffect1042ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 and not isNil(var_36_6) then
				if arg_33_1.var_.characterEffect1042ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_7)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1042ui_story then
				arg_33_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_36_8 = 0
			local var_36_9 = 1.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(114111008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 44 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 44)

				if (44 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 44)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111008", "story_v_out_114111.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111008", "story_v_out_114111.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_114111", "114111008", "story_v_out_114111.awb")

						arg_33_1:RecordAudio("114111008", var_36_15)
						arg_33_1:RecordAudio("114111008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114111", "114111008", "story_v_out_114111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114111", "114111008", "story_v_out_114111.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play114111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114111009
		arg_37_1.duration_ = 10.37

		local var_37_0 = {
			ja = 10.366,
			ko = 6.4,
			zh = 7.266,
			en = 7.433
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
				arg_37_0:Play114111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1067ui_story"]) and arg_37_1.var_.characterEffect1067ui_story == nil then
				arg_37_1.var_.characterEffect1067ui_story = arg_37_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1067ui_story"]) then
				if arg_37_1.var_.characterEffect1067ui_story and not isNil(arg_37_1.actors_["1067ui_story"]) then
					arg_37_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1067ui_story"]) and arg_37_1.var_.characterEffect1067ui_story then
				arg_37_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_1 = arg_37_1.actors_["1042ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1042ui_story == nil then
				arg_37_1.var_.characterEffect1042ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1042ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1042ui_story then
				arg_37_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_40_4 = 0
			local var_40_5 = 0.675

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(114111009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 27 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 27)

				if (27 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 27)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111009", "story_v_out_114111.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111009", "story_v_out_114111.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_114111", "114111009", "story_v_out_114111.awb")

						arg_37_1:RecordAudio("114111009", var_40_11)
						arg_37_1:RecordAudio("114111009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114111", "114111009", "story_v_out_114111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114111", "114111009", "story_v_out_114111.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114111010
		arg_41_1.duration_ = 6.37

		local var_41_0 = {
			ja = 5.7,
			ko = 5.333,
			zh = 4.833,
			en = 6.366
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
				arg_41_0:Play114111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1042ui_story"]) and arg_41_1.var_.characterEffect1042ui_story == nil then
				arg_41_1.var_.characterEffect1042ui_story = arg_41_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1042ui_story"]) then
				if arg_41_1.var_.characterEffect1042ui_story and not isNil(arg_41_1.actors_["1042ui_story"]) then
					arg_41_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1042ui_story"]) and arg_41_1.var_.characterEffect1042ui_story then
				arg_41_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_44_1 = arg_41_1.actors_["1067ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1067ui_story == nil then
				arg_41_1.var_.characterEffect1067ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1067ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1067ui_story then
				arg_41_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_4 = 0
			local var_44_5 = 0.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(114111010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 22 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 22)

				if (22 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 22)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111010", "story_v_out_114111.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111010", "story_v_out_114111.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_114111", "114111010", "story_v_out_114111.awb")

						arg_41_1:RecordAudio("114111010", var_44_11)
						arg_41_1:RecordAudio("114111010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114111", "114111010", "story_v_out_114111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114111", "114111010", "story_v_out_114111.awb")
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

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114111011
		arg_45_1.duration_ = 6.03

		local var_45_0 = {
			ja = 6.033,
			ko = 2.9,
			zh = 3.666,
			en = 4.1
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
				arg_45_0:Play114111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_48_0 = arg_45_1.actors_["1042ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1042ui_story == nil then
				arg_45_1.var_.characterEffect1042ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_1 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(var_48_0) then
				if arg_45_1.var_.characterEffect1042ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1042ui_story then
				arg_45_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_48_3 = arg_45_1.actors_["1067ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1067ui_story == nil then
				arg_45_1.var_.characterEffect1067ui_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect1067ui_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_4)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1067ui_story then
				arg_45_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_48_5 = 0
			local var_48_6 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(114111011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 9 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 9)

				if (9 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 9)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111011", "story_v_out_114111.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111011", "story_v_out_114111.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_114111", "114111011", "story_v_out_114111.awb")

						arg_45_1:RecordAudio("114111011", var_48_12)
						arg_45_1:RecordAudio("114111011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114111", "114111011", "story_v_out_114111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114111", "114111011", "story_v_out_114111.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114111012
		arg_49_1.duration_ = 14.6

		local var_49_0 = {
			ja = 14.6,
			ko = 10.433,
			zh = 9.966,
			en = 13.1
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
				arg_49_0:Play114111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1067ui_story"]) and arg_49_1.var_.characterEffect1067ui_story == nil then
				arg_49_1.var_.characterEffect1067ui_story = arg_49_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1067ui_story"]) then
				if arg_49_1.var_.characterEffect1067ui_story and not isNil(arg_49_1.actors_["1067ui_story"]) then
					arg_49_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1067ui_story"]) and arg_49_1.var_.characterEffect1067ui_story then
				arg_49_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_52_2 = arg_49_1.actors_["1042ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1042ui_story == nil then
				arg_49_1.var_.characterEffect1042ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1042ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1042ui_story then
				arg_49_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 1.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(114111012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 43 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 43)

				if (43 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 43)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111012", "story_v_out_114111.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111012", "story_v_out_114111.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_114111", "114111012", "story_v_out_114111.awb")

						arg_49_1:RecordAudio("114111012", var_52_11)
						arg_49_1:RecordAudio("114111012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114111", "114111012", "story_v_out_114111.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114111", "114111012", "story_v_out_114111.awb")
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114111013
		arg_53_1.duration_ = 10.8

		local var_53_0 = {
			ja = 9.533,
			ko = 10.8,
			zh = 10.466,
			en = 10.433
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
				arg_53_0:Play114111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_56_0 = 0
			local var_56_1 = 1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(114111013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 40 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 40)

				if (40 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_3) / 40)) > 0 and var_56_1 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111013", "story_v_out_114111.awb") ~= 0 then
					local var_56_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111013", "story_v_out_114111.awb") / 1000

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end

					if var_56_2.prefab_name ~= "" and arg_53_1.actors_[var_56_2.prefab_name] ~= nil then
						local var_56_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_2.prefab_name].transform, "story_v_out_114111", "114111013", "story_v_out_114111.awb")

						arg_53_1:RecordAudio("114111013", var_56_7)
						arg_53_1:RecordAudio("114111013", var_56_7)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114111", "114111013", "story_v_out_114111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114111", "114111013", "story_v_out_114111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_8 and arg_53_1.time_ < var_56_0 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114111014
		arg_57_1.duration_ = 13.7

		local var_57_0 = {
			ja = 12.266,
			ko = 13.7,
			zh = 12.366,
			en = 12.533
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
				arg_57_0:Play114111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_60_0 = 0
			local var_60_1 = 1.1

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(114111014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 44 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 44)

				if (44 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 44)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111014", "story_v_out_114111.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111014", "story_v_out_114111.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_out_114111", "114111014", "story_v_out_114111.awb")

						arg_57_1:RecordAudio("114111014", var_60_7)
						arg_57_1:RecordAudio("114111014", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114111", "114111014", "story_v_out_114111.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114111", "114111014", "story_v_out_114111.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114111015
		arg_61_1.duration_ = 12.3

		local var_61_0 = {
			ja = 12.3,
			ko = 10.333,
			zh = 11.2,
			en = 10.7
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
				arg_61_0:Play114111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_64_0 = arg_61_1.actors_["1042ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1042ui_story == nil then
				arg_61_1.var_.characterEffect1042ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_1 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 and not isNil(var_64_0) then
				if arg_61_1.var_.characterEffect1042ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1042ui_story then
				arg_61_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_64_3 = arg_61_1.actors_["1067ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1067ui_story == nil then
				arg_61_1.var_.characterEffect1067ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1067ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_4)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1067ui_story then
				arg_61_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_64_5 = 0
			local var_64_6 = 1.25

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(114111015)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 50 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 50)

				if (50 <= 0 and var_64_6 or var_64_6 * (utf8.len(var_64_8) / 50)) > 0 and var_64_6 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_5
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111015", "story_v_out_114111.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111015", "story_v_out_114111.awb") / 1000

					if var_64_11 + var_64_5 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_5
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_114111", "114111015", "story_v_out_114111.awb")

						arg_61_1:RecordAudio("114111015", var_64_12)
						arg_61_1:RecordAudio("114111015", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114111", "114111015", "story_v_out_114111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114111", "114111015", "story_v_out_114111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_6, arg_61_1.talkMaxDuration)

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_5) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_5 + var_64_13 and arg_61_1.time_ < var_64_5 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114111016
		arg_65_1.duration_ = 7.13

		local var_65_0 = {
			ja = 5.4,
			ko = 5.366,
			zh = 6.166,
			en = 7.133
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
				arg_65_0:Play114111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) and arg_65_1.var_.characterEffect1042ui_story == nil then
				arg_65_1.var_.characterEffect1042ui_story = arg_65_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) then
				if arg_65_1.var_.characterEffect1042ui_story and not isNil(arg_65_1.actors_["1042ui_story"]) then
					arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1042ui_story"]) and arg_65_1.var_.characterEffect1042ui_story then
				arg_65_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_68_1 = arg_65_1.actors_["1067ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1067ui_story == nil then
				arg_65_1.var_.characterEffect1067ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1067ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1067ui_story then
				arg_65_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(114111016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 26 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 26)

				if (26 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 26)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111016", "story_v_out_114111.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111016", "story_v_out_114111.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_114111", "114111016", "story_v_out_114111.awb")

						arg_65_1:RecordAudio("114111016", var_68_11)
						arg_65_1:RecordAudio("114111016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114111", "114111016", "story_v_out_114111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114111", "114111016", "story_v_out_114111.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114111017
		arg_69_1.duration_ = 10.87

		local var_69_0 = {
			ja = 9.366,
			ko = 10.2,
			zh = 10.866,
			en = 9.833
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
				arg_69_0:Play114111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_72_0 = 0
			local var_72_1 = 1.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(114111017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 52 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 52)

				if (52 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 52)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111017", "story_v_out_114111.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111017", "story_v_out_114111.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_114111", "114111017", "story_v_out_114111.awb")

						arg_69_1:RecordAudio("114111017", var_72_7)
						arg_69_1:RecordAudio("114111017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114111", "114111017", "story_v_out_114111.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114111", "114111017", "story_v_out_114111.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114111018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114111018
		arg_73_1.duration_ = 16.7

		local var_73_0 = {
			ja = 16.7,
			ko = 11.966,
			zh = 11.166,
			en = 12.1
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114111019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_76_0 = arg_73_1.actors_["1042ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1042ui_story == nil then
				arg_73_1.var_.characterEffect1042ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_1 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(var_76_0) then
				if arg_73_1.var_.characterEffect1042ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1042ui_story then
				arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_76_3 = arg_73_1.actors_["1067ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1067ui_story == nil then
				arg_73_1.var_.characterEffect1067ui_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect1067ui_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_4)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect1067ui_story then
				arg_73_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_76_5 = 0
			local var_76_6 = 1.1

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(114111018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 44 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 44)

				if (44 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 44)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111018", "story_v_out_114111.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111018", "story_v_out_114111.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_114111", "114111018", "story_v_out_114111.awb")

						arg_73_1:RecordAudio("114111018", var_76_12)
						arg_73_1:RecordAudio("114111018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114111", "114111018", "story_v_out_114111.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114111", "114111018", "story_v_out_114111.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_13 and arg_73_1.time_ < var_76_5 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114111019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114111019
		arg_77_1.duration_ = 10.9

		local var_77_0 = {
			ja = 10.9,
			ko = 10.9,
			zh = 10.866,
			en = 8.2
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114111020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1067ui_story"]) and arg_77_1.var_.characterEffect1067ui_story == nil then
				arg_77_1.var_.characterEffect1067ui_story = arg_77_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1067ui_story"]) then
				if arg_77_1.var_.characterEffect1067ui_story and not isNil(arg_77_1.actors_["1067ui_story"]) then
					arg_77_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1067ui_story"]) and arg_77_1.var_.characterEffect1067ui_story then
				arg_77_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_80_2 = arg_77_1.actors_["1042ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1042ui_story == nil then
				arg_77_1.var_.characterEffect1042ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1042ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1042ui_story then
				arg_77_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_80_4 = 0
			local var_80_5 = 1.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(114111019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 47 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 47)

				if (47 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 47)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111019", "story_v_out_114111.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111019", "story_v_out_114111.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_114111", "114111019", "story_v_out_114111.awb")

						arg_77_1:RecordAudio("114111019", var_80_11)
						arg_77_1:RecordAudio("114111019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114111", "114111019", "story_v_out_114111.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114111", "114111019", "story_v_out_114111.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114111020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114111020
		arg_81_1.duration_ = 10.53

		local var_81_0 = {
			ja = 10.533,
			ko = 8,
			zh = 8.633,
			en = 8.566
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114111021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1042ui_story"]) and arg_81_1.var_.characterEffect1042ui_story == nil then
				arg_81_1.var_.characterEffect1042ui_story = arg_81_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1042ui_story"]) then
				if arg_81_1.var_.characterEffect1042ui_story and not isNil(arg_81_1.actors_["1042ui_story"]) then
					arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1042ui_story"]) and arg_81_1.var_.characterEffect1042ui_story then
				arg_81_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1067ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1067ui_story == nil then
				arg_81_1.var_.characterEffect1067ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1067ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1067ui_story then
				arg_81_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_84_4 = 0
			local var_84_5 = 0.65

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(114111020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 26 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 26)

				if (26 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 26)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111020", "story_v_out_114111.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111020", "story_v_out_114111.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_114111", "114111020", "story_v_out_114111.awb")

						arg_81_1:RecordAudio("114111020", var_84_11)
						arg_81_1:RecordAudio("114111020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114111", "114111020", "story_v_out_114111.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114111", "114111020", "story_v_out_114111.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114111021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114111021
		arg_85_1.duration_ = 3.4

		local var_85_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.366,
			en = 3.4
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114111022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_88_0 = arg_85_1.actors_["1042ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1042ui_story == nil then
				arg_85_1.var_.characterEffect1042ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_1 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_1 and not isNil(var_88_0) then
				if arg_85_1.var_.characterEffect1042ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_1)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_1 and arg_85_1.time_ < 0 + var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1042ui_story then
				arg_85_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_88_2 = arg_85_1.actors_["1067ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1067ui_story == nil then
				arg_85_1.var_.characterEffect1067ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect1067ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect1067ui_story then
				arg_85_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_88_5 = 0
			local var_88_6 = 0.05

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(114111021)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 2 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 2)

				if (2 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 2)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111021", "story_v_out_114111.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111021", "story_v_out_114111.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_114111", "114111021", "story_v_out_114111.awb")

						arg_85_1:RecordAudio("114111021", var_88_12)
						arg_85_1:RecordAudio("114111021", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114111", "114111021", "story_v_out_114111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114111", "114111021", "story_v_out_114111.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114111022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114111022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play114111023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1067ui_story"]) and arg_89_1.var_.characterEffect1067ui_story == nil then
				arg_89_1.var_.characterEffect1067ui_story = arg_89_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1067ui_story"]) then
				if arg_89_1.var_.characterEffect1067ui_story and not isNil(arg_89_1.actors_["1067ui_story"]) then
					arg_89_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1067ui_story"]) and arg_89_1.var_.characterEffect1067ui_story then
				arg_89_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(114111022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 18 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 18)

				if (18 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 18)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114111023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114111023
		arg_93_1.duration_ = 15.5

		local var_93_0 = {
			ja = 14.7,
			ko = 14.633,
			zh = 14.166,
			en = 15.5
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
				arg_93_0:Play114111024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action475")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_0 = arg_93_1.actors_["1067ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1067ui_story == nil then
				arg_93_1.var_.characterEffect1067ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_1 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 and not isNil(var_96_0) then
				if arg_93_1.var_.characterEffect1067ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1067ui_story then
				arg_93_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_96_3 = 0
			local var_96_4 = 1.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(114111023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_8 = 59 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 59)

				if (59 <= 0 and var_96_4 or var_96_4 * (utf8.len(var_96_6) / 59)) > 0 and var_96_4 < var_96_8 then
					arg_93_1.talkMaxDuration = var_96_8

					if var_96_8 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_3
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111023", "story_v_out_114111.awb") ~= 0 then
					local var_96_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111023", "story_v_out_114111.awb") / 1000

					if var_96_9 + var_96_3 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_3
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_114111", "114111023", "story_v_out_114111.awb")

						arg_93_1:RecordAudio("114111023", var_96_10)
						arg_93_1:RecordAudio("114111023", var_96_10)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114111", "114111023", "story_v_out_114111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114111", "114111023", "story_v_out_114111.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_11 = math.max(var_96_4, arg_93_1.talkMaxDuration)

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_11 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_3) / var_96_11

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_3 + var_96_11 and arg_93_1.time_ < var_96_3 + var_96_11 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114111024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114111024
		arg_97_1.duration_ = 14.07

		local var_97_0 = {
			ja = 11.3,
			ko = 14.066,
			zh = 12.633,
			en = 12.6
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
				arg_97_0:Play114111025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action457")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_100_0 = 0
			local var_100_1 = 1.3

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(114111024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 52 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 52)

				if (52 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 52)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111024", "story_v_out_114111.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111024", "story_v_out_114111.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_114111", "114111024", "story_v_out_114111.awb")

						arg_97_1:RecordAudio("114111024", var_100_7)
						arg_97_1:RecordAudio("114111024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_114111", "114111024", "story_v_out_114111.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_114111", "114111024", "story_v_out_114111.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114111025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114111025
		arg_101_1.duration_ = 12.23

		local var_101_0 = {
			ja = 12.233,
			ko = 8.933,
			zh = 9.966,
			en = 11.333
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
				arg_101_0:Play114111026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1067ui_story"]) and arg_101_1.var_.characterEffect1067ui_story == nil then
				arg_101_1.var_.characterEffect1067ui_story = arg_101_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1067ui_story"]) then
				if arg_101_1.var_.characterEffect1067ui_story and not isNil(arg_101_1.actors_["1067ui_story"]) then
					arg_101_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1067ui_story"]) and arg_101_1.var_.characterEffect1067ui_story then
				arg_101_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_104_1 = arg_101_1.actors_["1042ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1042ui_story == nil then
				arg_101_1.var_.characterEffect1042ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1042ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1042ui_story then
				arg_101_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_104_4 = 0
			local var_104_5 = 0.975

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(114111025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 39 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 39)

				if (39 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 39)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111025", "story_v_out_114111.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111025", "story_v_out_114111.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_114111", "114111025", "story_v_out_114111.awb")

						arg_101_1:RecordAudio("114111025", var_104_11)
						arg_101_1:RecordAudio("114111025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114111", "114111025", "story_v_out_114111.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114111", "114111025", "story_v_out_114111.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114111026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114111026
		arg_105_1.duration_ = 12.63

		local var_105_0 = {
			ja = 12.5,
			ko = 9.133,
			zh = 8.966,
			en = 12.633
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play114111027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_0 = 0
			local var_108_1 = 1.025

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(114111026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 41 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 41)

				if (41 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 41)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111026", "story_v_out_114111.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111026", "story_v_out_114111.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_out_114111", "114111026", "story_v_out_114111.awb")

						arg_105_1:RecordAudio("114111026", var_108_7)
						arg_105_1:RecordAudio("114111026", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114111", "114111026", "story_v_out_114111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114111", "114111026", "story_v_out_114111.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114111027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114111027
		arg_109_1.duration_ = 4.2

		local var_109_0 = {
			ja = 4.2,
			ko = 2.7,
			zh = 3.2,
			en = 3.2
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114111028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_112_0 = arg_109_1.actors_["1067ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1067ui_story == nil then
				arg_109_1.var_.characterEffect1067ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_1 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(var_112_0) then
				if arg_109_1.var_.characterEffect1067ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1067ui_story then
				arg_109_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_112_3 = arg_109_1.actors_["1042ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1042ui_story == nil then
				arg_109_1.var_.characterEffect1042ui_story = var_112_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_4 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 and not isNil(var_112_3) then
				if arg_109_1.var_.characterEffect1042ui_story and not isNil(var_112_3) then
					arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_4)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 and not isNil(var_112_3) and arg_109_1.var_.characterEffect1042ui_story then
				arg_109_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_112_5 = 0
			local var_112_6 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(114111027)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 12 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 12)

				if (12 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 12)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111027", "story_v_out_114111.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111027", "story_v_out_114111.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_114111", "114111027", "story_v_out_114111.awb")

						arg_109_1:RecordAudio("114111027", var_112_12)
						arg_109_1:RecordAudio("114111027", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114111", "114111027", "story_v_out_114111.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114111", "114111027", "story_v_out_114111.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114111028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114111028
		arg_113_1.duration_ = 7.4

		local var_113_0 = {
			ja = 5.4,
			ko = 7.4,
			zh = 6.8,
			en = 6.733
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114111029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1067ui_story"]) and arg_113_1.var_.characterEffect1067ui_story == nil then
				arg_113_1.var_.characterEffect1067ui_story = arg_113_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1067ui_story"]) then
				if arg_113_1.var_.characterEffect1067ui_story and not isNil(arg_113_1.actors_["1067ui_story"]) then
					arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1067ui_story"]) and arg_113_1.var_.characterEffect1067ui_story then
				arg_113_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_116_1 = arg_113_1.actors_["1042ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1042ui_story == nil then
				arg_113_1.var_.characterEffect1042ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1042ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1042ui_story then
				arg_113_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.675

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(114111028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 27 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 27)

				if (27 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 27)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111028", "story_v_out_114111.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111028", "story_v_out_114111.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_114111", "114111028", "story_v_out_114111.awb")

						arg_113_1:RecordAudio("114111028", var_116_11)
						arg_113_1:RecordAudio("114111028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114111", "114111028", "story_v_out_114111.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114111", "114111028", "story_v_out_114111.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114111029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114111029
		arg_117_1.duration_ = 11

		local var_117_0 = {
			ja = 11,
			ko = 9.3,
			zh = 8.7,
			en = 11
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114111030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_120_0 = 0
			local var_120_1 = 1.05

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(114111029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 42 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 42)

				if (42 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 42)) > 0 and var_120_1 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111029", "story_v_out_114111.awb") ~= 0 then
					local var_120_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111029", "story_v_out_114111.awb") / 1000

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end

					if var_120_2.prefab_name ~= "" and arg_117_1.actors_[var_120_2.prefab_name] ~= nil then
						local var_120_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_2.prefab_name].transform, "story_v_out_114111", "114111029", "story_v_out_114111.awb")

						arg_117_1:RecordAudio("114111029", var_120_7)
						arg_117_1:RecordAudio("114111029", var_120_7)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114111", "114111029", "story_v_out_114111.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114111", "114111029", "story_v_out_114111.awb")
				end

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
	Play114111030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114111030
		arg_121_1.duration_ = 6

		local var_121_0 = {
			ja = 5.933,
			ko = 4.733,
			zh = 6,
			en = 5.7
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
				arg_121_0:Play114111031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_0 = arg_121_1.actors_["1067ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1067ui_story == nil then
				arg_121_1.var_.characterEffect1067ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_1 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 and not isNil(var_124_0) then
				if arg_121_1.var_.characterEffect1067ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1067ui_story then
				arg_121_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_124_3 = arg_121_1.actors_["1042ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_4)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect1042ui_story then
				arg_121_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_124_5 = 0
			local var_124_6 = 0.65

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(114111030)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 26 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 26)

				if (26 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 26)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111030", "story_v_out_114111.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111030", "story_v_out_114111.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_114111", "114111030", "story_v_out_114111.awb")

						arg_121_1:RecordAudio("114111030", var_124_12)
						arg_121_1:RecordAudio("114111030", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114111", "114111030", "story_v_out_114111.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114111", "114111030", "story_v_out_114111.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114111031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114111031
		arg_125_1.duration_ = 11.27

		local var_125_0 = {
			ja = 11.266,
			ko = 10.5,
			zh = 7.8,
			en = 9.866
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114111032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story == nil then
				arg_125_1.var_.characterEffect1042ui_story = arg_125_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) then
				if arg_125_1.var_.characterEffect1042ui_story and not isNil(arg_125_1.actors_["1042ui_story"]) then
					arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1042ui_story"]) and arg_125_1.var_.characterEffect1042ui_story then
				arg_125_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["1067ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1067ui_story == nil then
				arg_125_1.var_.characterEffect1067ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect1067ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect1067ui_story then
				arg_125_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			local var_128_4 = 0
			local var_128_5 = 0.9

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(114111031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 36 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 36)

				if (36 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 36)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111031", "story_v_out_114111.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111031", "story_v_out_114111.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_114111", "114111031", "story_v_out_114111.awb")

						arg_125_1:RecordAudio("114111031", var_128_11)
						arg_125_1:RecordAudio("114111031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114111", "114111031", "story_v_out_114111.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114111", "114111031", "story_v_out_114111.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114111032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114111032
		arg_129_1.duration_ = 5.57

		local var_129_0 = {
			ja = 4.266,
			ko = 3.433,
			zh = 5.566,
			en = 3.766
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
				arg_129_0:Play114111033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_132_0 = arg_129_1.actors_["1067ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1067ui_story == nil then
				arg_129_1.var_.characterEffect1067ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_1 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 and not isNil(var_132_0) then
				if arg_129_1.var_.characterEffect1067ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1067ui_story then
				arg_129_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_132_3 = arg_129_1.actors_["1042ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1042ui_story == nil then
				arg_129_1.var_.characterEffect1042ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect1042ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_4)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1042ui_story then
				arg_129_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_132_5 = 0
			local var_132_6 = 0.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_7 = arg_129_1:GetWordFromCfg(114111032)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 18 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 18)

				if (18 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 18)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111032", "story_v_out_114111.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111032", "story_v_out_114111.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_114111", "114111032", "story_v_out_114111.awb")

						arg_129_1:RecordAudio("114111032", var_132_12)
						arg_129_1:RecordAudio("114111032", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114111", "114111032", "story_v_out_114111.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114111", "114111032", "story_v_out_114111.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114111033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114111033
		arg_133_1.duration_ = 7.6

		local var_133_0 = {
			ja = 7.366,
			ko = 4.533,
			zh = 5.766,
			en = 7.6
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
				arg_133_0:Play114111034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story == nil then
				arg_133_1.var_.characterEffect1067ui_story = arg_133_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) then
				if arg_133_1.var_.characterEffect1067ui_story and not isNil(arg_133_1.actors_["1067ui_story"]) then
					arg_133_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1067ui_story"]) and arg_133_1.var_.characterEffect1067ui_story then
				arg_133_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_2")
			end

			local var_136_1 = arg_133_1.actors_["1042ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1042ui_story == nil then
				arg_133_1.var_.characterEffect1042ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1042ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1042ui_story then
				arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 0.65

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(114111033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 26 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 26)

				if (26 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 26)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111033", "story_v_out_114111.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111033", "story_v_out_114111.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_114111", "114111033", "story_v_out_114111.awb")

						arg_133_1:RecordAudio("114111033", var_136_11)
						arg_133_1:RecordAudio("114111033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114111", "114111033", "story_v_out_114111.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114111", "114111033", "story_v_out_114111.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114111034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114111034
		arg_137_1.duration_ = 5.2

		local var_137_0 = {
			ja = 5.2,
			ko = 3.566,
			zh = 3.2,
			en = 3.333
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
				arg_137_0:Play114111035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_0 = arg_137_1.actors_["1067ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1067ui_story == nil then
				arg_137_1.var_.characterEffect1067ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_1 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 and not isNil(var_140_0) then
				if arg_137_1.var_.characterEffect1067ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1067ui_story then
				arg_137_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_140_3 = arg_137_1.actors_["1042ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1042ui_story == nil then
				arg_137_1.var_.characterEffect1042ui_story = var_140_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_4 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 and not isNil(var_140_3) then
				if arg_137_1.var_.characterEffect1042ui_story and not isNil(var_140_3) then
					arg_137_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_4)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect1042ui_story then
				arg_137_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_140_5 = 0
			local var_140_6 = 0.325

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(114111034)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 13 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 13)

				if (13 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 13)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111034", "story_v_out_114111.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111034", "story_v_out_114111.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_114111", "114111034", "story_v_out_114111.awb")

						arg_137_1:RecordAudio("114111034", var_140_12)
						arg_137_1:RecordAudio("114111034", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114111", "114111034", "story_v_out_114111.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114111", "114111034", "story_v_out_114111.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114111035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114111035
		arg_141_1.duration_ = 8.5

		local var_141_0 = {
			ja = 8.5,
			ko = 4.366,
			zh = 6.7,
			en = 7.433
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
				arg_141_0:Play114111036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_144_0 = arg_141_1.actors_["1042ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1042ui_story == nil then
				arg_141_1.var_.characterEffect1042ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_1 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 and not isNil(var_144_0) then
				if arg_141_1.var_.characterEffect1042ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1042ui_story then
				arg_141_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_144_3 = arg_141_1.actors_["1067ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1067ui_story == nil then
				arg_141_1.var_.characterEffect1067ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect1067ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_4)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1067ui_story then
				arg_141_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_144_5 = 0
			local var_144_6 = 0.55

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(114111035)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 22 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 22)

				if (22 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 22)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111035", "story_v_out_114111.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111035", "story_v_out_114111.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_114111", "114111035", "story_v_out_114111.awb")

						arg_141_1:RecordAudio("114111035", var_144_12)
						arg_141_1:RecordAudio("114111035", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_114111", "114111035", "story_v_out_114111.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_114111", "114111035", "story_v_out_114111.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114111036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114111036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play114111037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1067ui_story = arg_145_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).z)
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles = arg_145_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1067ui_story"].transform.position).z)
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1067ui_story"].transform.localEulerAngles = arg_145_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1042ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1042ui_story = var_148_1.localPosition
			end

			local var_148_2 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_2)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			local var_148_3 = 0
			local var_148_4 = 1.075

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_5 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(114111036).content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 43 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 43)

				if (43 <= 0 and var_148_4 or var_148_4 * (utf8.len(var_148_5) / 43)) > 0 and var_148_4 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_3
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_4, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_3) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_8 and arg_145_1.time_ < var_148_3 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play114111037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114111037
		arg_149_1.duration_ = 15.17

		local var_149_0 = {
			ja = 13.333,
			ko = 11.933,
			zh = 13.566,
			en = 15.166
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114111038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1067ui_story = arg_149_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).z)
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles = arg_149_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_149_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1067ui_story"].transform.position).z)
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1067ui_story"].transform.localEulerAngles = arg_149_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_1 = arg_149_1.actors_["1067ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1067ui_story == nil then
				arg_149_1.var_.characterEffect1067ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1067ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1067ui_story then
				arg_149_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1042ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1042ui_story = var_152_4.localPosition
			end

			local var_152_5 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 then
				var_152_4.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_149_1.time_ - 0) / var_152_5)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 then
				var_152_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			local var_152_6 = arg_149_1.actors_["1042ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1042ui_story == nil then
				arg_149_1.var_.characterEffect1042ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_7 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 and not isNil(var_152_6) then
				if arg_149_1.var_.characterEffect1042ui_story and not isNil(var_152_6) then
					arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_7)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1042ui_story then
				arg_149_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_152_8 = 0
			local var_152_9 = 1.325

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(114111037)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 53 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 53)

				if (53 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 53)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111037", "story_v_out_114111.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111037", "story_v_out_114111.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_114111", "114111037", "story_v_out_114111.awb")

						arg_149_1:RecordAudio("114111037", var_152_15)
						arg_149_1:RecordAudio("114111037", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114111", "114111037", "story_v_out_114111.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114111", "114111037", "story_v_out_114111.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play114111038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114111038
		arg_153_1.duration_ = 9.27

		local var_153_0 = {
			ja = 8.166,
			ko = 9.266,
			zh = 8.2,
			en = 6.7
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
				arg_153_0:Play114111039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_156_0 = arg_153_1.actors_["1042ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1042ui_story == nil then
				arg_153_1.var_.characterEffect1042ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_1 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 and not isNil(var_156_0) then
				if arg_153_1.var_.characterEffect1042ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1042ui_story then
				arg_153_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_156_3 = arg_153_1.actors_["1067ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect1067ui_story == nil then
				arg_153_1.var_.characterEffect1067ui_story = var_156_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_4 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 and not isNil(var_156_3) then
				if arg_153_1.var_.characterEffect1067ui_story and not isNil(var_156_3) then
					arg_153_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_4)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 and not isNil(var_156_3) and arg_153_1.var_.characterEffect1067ui_story then
				arg_153_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_156_5 = 0
			local var_156_6 = 0.8

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(114111038)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 32 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 32)

				if (32 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 32)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111038", "story_v_out_114111.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111038", "story_v_out_114111.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_114111", "114111038", "story_v_out_114111.awb")

						arg_153_1:RecordAudio("114111038", var_156_12)
						arg_153_1:RecordAudio("114111038", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114111", "114111038", "story_v_out_114111.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114111", "114111038", "story_v_out_114111.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114111039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114111039
		arg_157_1.duration_ = 6.33

		local var_157_0 = {
			ja = 5.166,
			ko = 6.333,
			zh = 6.1,
			en = 6.3
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play114111040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_2")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_160_0 = arg_157_1.actors_["1067ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1067ui_story == nil then
				arg_157_1.var_.characterEffect1067ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_1 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 and not isNil(var_160_0) then
				if arg_157_1.var_.characterEffect1067ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1067ui_story then
				arg_157_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_160_3 = arg_157_1.actors_["1042ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect1042ui_story == nil then
				arg_157_1.var_.characterEffect1042ui_story = var_160_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_4 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 and not isNil(var_160_3) then
				if arg_157_1.var_.characterEffect1042ui_story and not isNil(var_160_3) then
					arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_4)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 and not isNil(var_160_3) and arg_157_1.var_.characterEffect1042ui_story then
				arg_157_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_160_5 = 0
			local var_160_6 = 0.625

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_7 = arg_157_1:GetWordFromCfg(114111039)
				local var_160_8 = arg_157_1:FormatText(var_160_7.content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 25 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 25)

				if (25 <= 0 and var_160_6 or var_160_6 * (utf8.len(var_160_8) / 25)) > 0 and var_160_6 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_5
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111039", "story_v_out_114111.awb") ~= 0 then
					local var_160_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111039", "story_v_out_114111.awb") / 1000

					if var_160_11 + var_160_5 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_11 + var_160_5
					end

					if var_160_7.prefab_name ~= "" and arg_157_1.actors_[var_160_7.prefab_name] ~= nil then
						local var_160_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_7.prefab_name].transform, "story_v_out_114111", "114111039", "story_v_out_114111.awb")

						arg_157_1:RecordAudio("114111039", var_160_12)
						arg_157_1:RecordAudio("114111039", var_160_12)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114111", "114111039", "story_v_out_114111.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114111", "114111039", "story_v_out_114111.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_13 = math.max(var_160_6, arg_157_1.talkMaxDuration)

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_13 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_5) / var_160_13

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_5 + var_160_13 and arg_157_1.time_ < var_160_5 + var_160_13 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play114111040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114111040
		arg_161_1.duration_ = 10.47

		local var_161_0 = {
			ja = 4.233,
			ko = 10.466,
			zh = 7.5,
			en = 7.5
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
				arg_161_0:Play114111041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_0 = 0
			local var_164_1 = 0.825

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_2 = arg_161_1:GetWordFromCfg(114111040)
				local var_164_3 = arg_161_1:FormatText(var_164_2.content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 33 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 33)

				if (33 <= 0 and var_164_1 or var_164_1 * (utf8.len(var_164_3) / 33)) > 0 and var_164_1 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111040", "story_v_out_114111.awb") ~= 0 then
					local var_164_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111040", "story_v_out_114111.awb") / 1000

					if var_164_6 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_6 + var_164_0
					end

					if var_164_2.prefab_name ~= "" and arg_161_1.actors_[var_164_2.prefab_name] ~= nil then
						local var_164_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_2.prefab_name].transform, "story_v_out_114111", "114111040", "story_v_out_114111.awb")

						arg_161_1:RecordAudio("114111040", var_164_7)
						arg_161_1:RecordAudio("114111040", var_164_7)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114111", "114111040", "story_v_out_114111.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114111", "114111040", "story_v_out_114111.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_8 and arg_161_1.time_ < var_164_0 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114111041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114111041
		arg_165_1.duration_ = 7.9

		local var_165_0 = {
			ja = 7.9,
			ko = 4.333,
			zh = 5.4,
			en = 6.033
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play114111042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_168_0 = arg_165_1.actors_["1042ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1042ui_story == nil then
				arg_165_1.var_.characterEffect1042ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_1 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 and not isNil(var_168_0) then
				if arg_165_1.var_.characterEffect1042ui_story and not isNil(var_168_0) then
					arg_165_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1042ui_story then
				arg_165_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_168_3 = arg_165_1.actors_["1067ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect1067ui_story == nil then
				arg_165_1.var_.characterEffect1067ui_story = var_168_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_4 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 and not isNil(var_168_3) then
				if arg_165_1.var_.characterEffect1067ui_story and not isNil(var_168_3) then
					arg_165_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_4)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 and not isNil(var_168_3) and arg_165_1.var_.characterEffect1067ui_story then
				arg_165_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_168_5 = 0
			local var_168_6 = 0.425

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_7 = arg_165_1:GetWordFromCfg(114111041)
				local var_168_8 = arg_165_1:FormatText(var_168_7.content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 17 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 17)

				if (17 <= 0 and var_168_6 or var_168_6 * (utf8.len(var_168_8) / 17)) > 0 and var_168_6 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_5
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111041", "story_v_out_114111.awb") ~= 0 then
					local var_168_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111041", "story_v_out_114111.awb") / 1000

					if var_168_11 + var_168_5 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_5
					end

					if var_168_7.prefab_name ~= "" and arg_165_1.actors_[var_168_7.prefab_name] ~= nil then
						local var_168_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_7.prefab_name].transform, "story_v_out_114111", "114111041", "story_v_out_114111.awb")

						arg_165_1:RecordAudio("114111041", var_168_12)
						arg_165_1:RecordAudio("114111041", var_168_12)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114111", "114111041", "story_v_out_114111.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114111", "114111041", "story_v_out_114111.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_6, arg_165_1.talkMaxDuration)

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_5) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_5 + var_168_13 and arg_165_1.time_ < var_168_5 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114111042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114111042
		arg_169_1.duration_ = 2.87

		local var_169_0 = {
			ja = 2.4,
			ko = 2.8,
			zh = 2.866,
			en = 2.7
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
				arg_169_0:Play114111043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action2_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_0 = arg_169_1.actors_["1067ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1067ui_story == nil then
				arg_169_1.var_.characterEffect1067ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_1 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 and not isNil(var_172_0) then
				if arg_169_1.var_.characterEffect1067ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect1067ui_story then
				arg_169_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_172_3 = arg_169_1.actors_["1042ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1042ui_story == nil then
				arg_169_1.var_.characterEffect1042ui_story = var_172_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_4 = 0.2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 and not isNil(var_172_3) then
				if arg_169_1.var_.characterEffect1042ui_story and not isNil(var_172_3) then
					arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_4)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 and not isNil(var_172_3) and arg_169_1.var_.characterEffect1042ui_story then
				arg_169_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_172_5 = 0
			local var_172_6 = 0.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_7 = arg_169_1:GetWordFromCfg(114111042)
				local var_172_8 = arg_169_1:FormatText(var_172_7.content)

				arg_169_1.text_.text = var_172_8

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_10 = 13 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 13)

				if (13 <= 0 and var_172_6 or var_172_6 * (utf8.len(var_172_8) / 13)) > 0 and var_172_6 < var_172_10 then
					arg_169_1.talkMaxDuration = var_172_10

					if var_172_10 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_5
					end
				end

				arg_169_1.text_.text = var_172_8
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111042", "story_v_out_114111.awb") ~= 0 then
					local var_172_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111042", "story_v_out_114111.awb") / 1000

					if var_172_11 + var_172_5 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_5
					end

					if var_172_7.prefab_name ~= "" and arg_169_1.actors_[var_172_7.prefab_name] ~= nil then
						local var_172_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_7.prefab_name].transform, "story_v_out_114111", "114111042", "story_v_out_114111.awb")

						arg_169_1:RecordAudio("114111042", var_172_12)
						arg_169_1:RecordAudio("114111042", var_172_12)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114111", "114111042", "story_v_out_114111.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114111", "114111042", "story_v_out_114111.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_13 = math.max(var_172_6, arg_169_1.talkMaxDuration)

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_13 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_5) / var_172_13

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_5 + var_172_13 and arg_169_1.time_ < var_172_5 + var_172_13 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play114111043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114111043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114111044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1042ui_story = arg_173_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).z)
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles = arg_173_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1042ui_story"].transform.position).z)
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1042ui_story"].transform.localEulerAngles = arg_173_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1067ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1067ui_story = var_176_1.localPosition
			end

			local var_176_2 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 then
				var_176_1.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_2)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 then
				var_176_1.localPosition = Vector3.New(0, 100, 0)
				var_176_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_1.position).x, (manager.ui.mainCamera.transform.position - var_176_1.position).y, (manager.ui.mainCamera.transform.position - var_176_1.position).z)
				var_176_1.localEulerAngles.z = 0
				var_176_1.localEulerAngles.x = 0
				var_176_1.localEulerAngles = var_176_1.localEulerAngles
			end

			local var_176_3 = 0
			local var_176_4 = 0.675

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_3 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_5 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(114111043).content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 27 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 27)

				if (27 <= 0 and var_176_4 or var_176_4 * (utf8.len(var_176_5) / 27)) > 0 and var_176_4 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_3 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_3
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_4, arg_173_1.talkMaxDuration)

			if var_176_3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_3 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_3) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_3 + var_176_8 and arg_173_1.time_ < var_176_3 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play114111044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114111044
		arg_177_1.duration_ = 6.9

		local var_177_0 = {
			ja = 6.9,
			ko = 3,
			zh = 5,
			en = 4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114111045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1042ui_story = arg_177_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).z)
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles = arg_177_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_177_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1042ui_story"].transform.position).z)
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1042ui_story"].transform.localEulerAngles = arg_177_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_180_1 = arg_177_1.actors_["1042ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1042ui_story == nil then
				arg_177_1.var_.characterEffect1042ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1042ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1042ui_story then
				arg_177_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 0.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(114111044)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)

				if (13 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 13)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111044", "story_v_out_114111.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111044", "story_v_out_114111.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_114111", "114111044", "story_v_out_114111.awb")

						arg_177_1:RecordAudio("114111044", var_180_11)
						arg_177_1:RecordAudio("114111044", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114111", "114111044", "story_v_out_114111.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114111", "114111044", "story_v_out_114111.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114111045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114111045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114111046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1042ui_story = arg_181_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).z)
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles = arg_181_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1042ui_story"].transform.position).z)
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1042ui_story"].transform.localEulerAngles = arg_181_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_184_1 = 0
			local var_184_2 = 0.85

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(114111045).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 34 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 34)

				if (34 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 34)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play114111046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114111046
		arg_185_1.duration_ = 7.47

		local var_185_0 = {
			ja = 7.466,
			ko = 7.333,
			zh = 4.6,
			en = 5.233
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114111047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1067ui_story = arg_185_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).z)
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles = arg_185_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_185_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).z)
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles = arg_185_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1042ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1042ui_story = var_188_1.localPosition
			end

			local var_188_2 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 then
				var_188_1.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_185_1.time_ - 0) / var_188_2)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 then
				var_188_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_188_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_1.position).x, (manager.ui.mainCamera.transform.position - var_188_1.position).y, (manager.ui.mainCamera.transform.position - var_188_1.position).z)
				var_188_1.localEulerAngles.z = 0
				var_188_1.localEulerAngles.x = 0
				var_188_1.localEulerAngles = var_188_1.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_188_3 = arg_185_1.actors_["1067ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1067ui_story == nil then
				arg_185_1.var_.characterEffect1067ui_story = var_188_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_4 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 and not isNil(var_188_3) then
				if arg_185_1.var_.characterEffect1067ui_story and not isNil(var_188_3) then
					arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 and not isNil(var_188_3) and arg_185_1.var_.characterEffect1067ui_story then
				arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_188_6 = arg_185_1.actors_["1042ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1042ui_story == nil then
				arg_185_1.var_.characterEffect1042ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect1042ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1042ui_story then
				arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_188_8 = 0
			local var_188_9 = 0.5

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(114111046)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 20 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 20)

				if (20 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 20)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111046", "story_v_out_114111.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111046", "story_v_out_114111.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_114111", "114111046", "story_v_out_114111.awb")

						arg_185_1:RecordAudio("114111046", var_188_15)
						arg_185_1:RecordAudio("114111046", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114111", "114111046", "story_v_out_114111.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114111", "114111046", "story_v_out_114111.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114111047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114111047
		arg_189_1.duration_ = 12.3

		local var_189_0 = {
			ja = 8.333,
			ko = 10.3,
			zh = 9.8,
			en = 12.3
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114111048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1042ui_story = arg_189_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).z)
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles = arg_189_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_189_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1042ui_story"].transform.position).z)
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1042ui_story"].transform.localEulerAngles = arg_189_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_192_1 = arg_189_1.actors_["1042ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story == nil then
				arg_189_1.var_.characterEffect1042ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1042ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1042ui_story then
				arg_189_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_192_4 = arg_189_1.actors_["1067ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1067ui_story == nil then
				arg_189_1.var_.characterEffect1067ui_story = var_192_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_5 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_5 and not isNil(var_192_4) then
				if arg_189_1.var_.characterEffect1067ui_story and not isNil(var_192_4) then
					arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_5)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_5 and arg_189_1.time_ < 0 + var_192_5 + arg_192_0 and not isNil(var_192_4) and arg_189_1.var_.characterEffect1067ui_story then
				arg_189_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_192_6 = 0
			local var_192_7 = 0.875

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_8 = arg_189_1:GetWordFromCfg(114111047)
				local var_192_9 = arg_189_1:FormatText(var_192_8.content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 35 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 35)

				if (35 <= 0 and var_192_7 or var_192_7 * (utf8.len(var_192_9) / 35)) > 0 and var_192_7 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_6
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111047", "story_v_out_114111.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_114111", "114111047", "story_v_out_114111.awb") / 1000

					if var_192_12 + var_192_6 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_6
					end

					if var_192_8.prefab_name ~= "" and arg_189_1.actors_[var_192_8.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_8.prefab_name].transform, "story_v_out_114111", "114111047", "story_v_out_114111.awb")

						arg_189_1:RecordAudio("114111047", var_192_13)
						arg_189_1:RecordAudio("114111047", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114111", "114111047", "story_v_out_114111.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114111", "114111047", "story_v_out_114111.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_7, arg_189_1.talkMaxDuration)

			if var_192_6 <= arg_189_1.time_ and arg_189_1.time_ < var_192_6 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_6) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_6 + var_192_14 and arg_189_1.time_ < var_192_6 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114111048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114111048
		arg_193_1.duration_ = 9

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114111049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.bgs_.OM0206 == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0206")
				var_196_0.name = "OM0206"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.OM0206 = var_196_0
			end

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= 2 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.OM0206

				arg_193_1.bgs_.OM0206.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "OM0206" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_5 = 2

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_5 then
				local var_196_6 = Color.New(0, 0, 0)

				var_196_6.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_4) / var_196_5)
				arg_193_1.mask_.color = var_196_6
			end

			if arg_193_1.time_ >= var_196_4 + var_196_5 and arg_193_1.time_ < var_196_4 + var_196_5 + arg_196_0 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = 1
				arg_193_1.mask_.color = var_196_7
			end

			local var_196_8 = 2

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_9 = 2

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 then
				local var_196_10 = Color.New(0, 0, 0)

				var_196_10.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_8) / var_196_9)
				arg_193_1.mask_.color = var_196_10
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 then
				local var_196_11 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_11.a = 0
				arg_193_1.mask_.color = var_196_11
			end

			local var_196_12 = arg_193_1.actors_["1042ui_story"].transform

			if 1.966 < arg_193_1.time_ and arg_193_1.time_ <= 1.966 + arg_196_0 then
				arg_193_1.var_.moveOldPos1042ui_story = var_196_12.localPosition
			end

			local var_196_13 = 0.001

			if 1.966 <= arg_193_1.time_ and arg_193_1.time_ < 1.966 + var_196_13 then
				var_196_12.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 1.966) / var_196_13)
				var_196_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_12.position).x, (manager.ui.mainCamera.transform.position - var_196_12.position).y, (manager.ui.mainCamera.transform.position - var_196_12.position).z)
				var_196_12.localEulerAngles.z = 0
				var_196_12.localEulerAngles.x = 0
				var_196_12.localEulerAngles = var_196_12.localEulerAngles
			end

			if arg_193_1.time_ >= 1.966 + var_196_13 and arg_193_1.time_ < 1.966 + var_196_13 + arg_196_0 then
				var_196_12.localPosition = Vector3.New(0, 100, 0)
				var_196_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_12.position).x, (manager.ui.mainCamera.transform.position - var_196_12.position).y, (manager.ui.mainCamera.transform.position - var_196_12.position).z)
				var_196_12.localEulerAngles.z = 0
				var_196_12.localEulerAngles.x = 0
				var_196_12.localEulerAngles = var_196_12.localEulerAngles
			end

			local var_196_14 = arg_193_1.actors_["1067ui_story"].transform

			if 1.966 < arg_193_1.time_ and arg_193_1.time_ <= 1.966 + arg_196_0 then
				arg_193_1.var_.moveOldPos1067ui_story = var_196_14.localPosition
			end

			local var_196_15 = 0.001

			if 1.966 <= arg_193_1.time_ and arg_193_1.time_ < 1.966 + var_196_15 then
				var_196_14.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 1.966) / var_196_15)
				var_196_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_14.position).x, (manager.ui.mainCamera.transform.position - var_196_14.position).y, (manager.ui.mainCamera.transform.position - var_196_14.position).z)
				var_196_14.localEulerAngles.z = 0
				var_196_14.localEulerAngles.x = 0
				var_196_14.localEulerAngles = var_196_14.localEulerAngles
			end

			if arg_193_1.time_ >= 1.966 + var_196_15 and arg_193_1.time_ < 1.966 + var_196_15 + arg_196_0 then
				var_196_14.localPosition = Vector3.New(0, 100, 0)
				var_196_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_14.position).x, (manager.ui.mainCamera.transform.position - var_196_14.position).y, (manager.ui.mainCamera.transform.position - var_196_14.position).z)
				var_196_14.localEulerAngles.z = 0
				var_196_14.localEulerAngles.x = 0
				var_196_14.localEulerAngles = var_196_14.localEulerAngles
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_16 = 4
			local var_196_17 = 1.675

			if 4 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_18 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_18:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_19 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(114111048).content)

				arg_193_1.text_.text = var_196_19

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_21 = 67 <= 0 and var_196_17 or var_196_17 * (utf8.len(var_196_19) / 67)

				if (67 <= 0 and var_196_17 or var_196_17 * (utf8.len(var_196_19) / 67)) > 0 and var_196_17 < var_196_21 then
					arg_193_1.talkMaxDuration = var_196_21
					var_196_16 = var_196_16 + 0.3

					if var_196_21 + var_196_16 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_21 + var_196_16
					end
				end

				arg_193_1.text_.text = var_196_19
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_22 = var_196_16 + 0.3
			local var_196_23 = math.max(var_196_17, arg_193_1.talkMaxDuration)

			if var_196_16 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_22 + var_196_23 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_22) / var_196_23

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_22 + var_196_23 and arg_193_1.time_ < var_196_22 + var_196_23 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play114111049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114111049
		arg_199_1.duration_ = 9.17

		local var_199_0 = {
			ja = 8.666,
			ko = 8.933,
			zh = 8.1,
			en = 9.166
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
				arg_199_0:Play114111050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(114111049)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 44 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 44)

				if (44 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 44)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111049", "story_v_out_114111.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111049", "story_v_out_114111.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_114111", "114111049", "story_v_out_114111.awb")

						arg_199_1:RecordAudio("114111049", var_202_6)
						arg_199_1:RecordAudio("114111049", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_114111", "114111049", "story_v_out_114111.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_114111", "114111049", "story_v_out_114111.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114111050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114111050
		arg_203_1.duration_ = 6.93

		local var_203_0 = {
			ja = 3.833,
			ko = 3.633,
			zh = 4.166,
			en = 6.933
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
				arg_203_0:Play114111051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(114111050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)

				if (20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111050", "story_v_out_114111.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111050", "story_v_out_114111.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_114111", "114111050", "story_v_out_114111.awb")

						arg_203_1:RecordAudio("114111050", var_206_6)
						arg_203_1:RecordAudio("114111050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_114111", "114111050", "story_v_out_114111.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_114111", "114111050", "story_v_out_114111.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114111051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114111051
		arg_207_1.duration_ = 8.07

		local var_207_0 = {
			ja = 5.2,
			ko = 7.4,
			zh = 7.033,
			en = 8.066
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
				arg_207_0:Play114111052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.875

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(114111051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 35 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 35)

				if (35 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 35)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111051", "story_v_out_114111.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111051", "story_v_out_114111.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_114111", "114111051", "story_v_out_114111.awb")

						arg_207_1:RecordAudio("114111051", var_210_6)
						arg_207_1:RecordAudio("114111051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_114111", "114111051", "story_v_out_114111.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_114111", "114111051", "story_v_out_114111.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114111052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114111052
		arg_211_1.duration_ = 11.83

		local var_211_0 = {
			ja = 10.9,
			ko = 9.433,
			zh = 10,
			en = 11.833
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114111053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.35

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[104].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:GetWordFromCfg(114111052)
				local var_214_2 = arg_211_1:FormatText(var_214_1.content)

				arg_211_1.text_.text = var_214_2

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_4 = 54 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 54)

				if (54 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_2) / 54)) > 0 and var_214_0 < var_214_4 then
					arg_211_1.talkMaxDuration = var_214_4

					if var_214_4 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_4 + 0
					end
				end

				arg_211_1.text_.text = var_214_2
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111052", "story_v_out_114111.awb") ~= 0 then
					local var_214_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111052", "story_v_out_114111.awb") / 1000

					if var_214_5 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + 0
					end

					if var_214_1.prefab_name ~= "" and arg_211_1.actors_[var_214_1.prefab_name] ~= nil then
						local var_214_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_1.prefab_name].transform, "story_v_out_114111", "114111052", "story_v_out_114111.awb")

						arg_211_1:RecordAudio("114111052", var_214_6)
						arg_211_1:RecordAudio("114111052", var_214_6)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114111", "114111052", "story_v_out_114111.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114111", "114111052", "story_v_out_114111.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_7 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_7

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114111053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114111053
		arg_215_1.duration_ = 5

		local var_215_0 = {
			ja = 4.466,
			ko = 5,
			zh = 4.4,
			en = 4.333
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play114111054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.525

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[105].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(114111053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 21 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 21)

				if (21 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 21)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111053", "story_v_out_114111.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111053", "story_v_out_114111.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_114111", "114111053", "story_v_out_114111.awb")

						arg_215_1:RecordAudio("114111053", var_218_6)
						arg_215_1:RecordAudio("114111053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_114111", "114111053", "story_v_out_114111.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_114111", "114111053", "story_v_out_114111.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play114111054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 114111054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play114111055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 1.3

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(114111054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 52)

				if (52 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 52)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play114111055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 114111055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play114111056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 1.75

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(114111055).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 70 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 70)

				if (70 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 70)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play114111056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 114111056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play114111057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.6

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(114111056).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 64 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 64)

				if (64 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 64)) > 0 and var_230_0 < var_230_3 then
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
	Play114111057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 114111057
		arg_231_1.duration_ = 4.77

		local var_231_0 = {
			ja = 3.3,
			ko = 2.666,
			zh = 3.8,
			en = 4.766
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
				arg_231_0:Play114111058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.25

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(114111057)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 10 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 10)

				if (10 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 10)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111057", "story_v_out_114111.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111057", "story_v_out_114111.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_114111", "114111057", "story_v_out_114111.awb")

						arg_231_1:RecordAudio("114111057", var_234_6)
						arg_231_1:RecordAudio("114111057", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_114111", "114111057", "story_v_out_114111.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_114111", "114111057", "story_v_out_114111.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play114111058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 114111058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play114111059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.225

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(114111058).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 49 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 49)

				if (49 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 49)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play114111059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 114111059
		arg_239_1.duration_ = 9.3

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play114111060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if arg_239_1.bgs_.F05_1 == nil then
				local var_242_0 = Object.Instantiate(arg_239_1.paintGo_)

				var_242_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F05_1")
				var_242_0.name = "F05_1"
				var_242_0.transform.parent = arg_239_1.stage_.transform
				var_242_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_239_1.bgs_.F05_1 = var_242_0
			end

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				local var_242_1 = arg_239_1.bgs_.F05_1

				arg_239_1.bgs_.F05_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_2 = var_242_1:GetComponent("SpriteRenderer")

				if var_242_2 and var_242_2.sprite then
					local var_242_3 = 2 * (var_242_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_1.transform.localScale = Vector3.New(var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, var_242_3 / var_242_2.sprite.bounds.size.y < var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x and var_242_3 * manager.ui.mainCameraCom_.aspect / var_242_2.sprite.bounds.size.x or var_242_3 / var_242_2.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "F05_1" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_4 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_5 = 2

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_5 then
				local var_242_6 = Color.New(0, 0, 0)

				var_242_6.a = Mathf.Lerp(0, 1, (arg_239_1.time_ - var_242_4) / var_242_5)
				arg_239_1.mask_.color = var_242_6
			end

			if arg_239_1.time_ >= var_242_4 + var_242_5 and arg_239_1.time_ < var_242_4 + var_242_5 + arg_242_0 then
				local var_242_7 = Color.New(0, 0, 0)

				var_242_7.a = 1
				arg_239_1.mask_.color = var_242_7
			end

			local var_242_8 = 2

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_9 = 2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 then
				local var_242_10 = Color.New(0, 0, 0)

				var_242_10.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_8) / var_242_9)
				arg_239_1.mask_.color = var_242_10
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 then
				local var_242_11 = Color.New(0, 0, 0)

				arg_239_1.mask_.enabled = false
				var_242_11.a = 0
				arg_239_1.mask_.color = var_242_11
			end

			local var_242_12 = arg_239_1.bgs_.F05_1.transform

			if 2 < arg_239_1.time_ and arg_239_1.time_ <= 2 + arg_242_0 then
				arg_239_1.var_.moveOldPosF05_1 = var_242_12.localPosition
			end

			local var_242_13 = 0.001

			if 2 <= arg_239_1.time_ and arg_239_1.time_ < 2 + var_242_13 then
				var_242_12.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF05_1, Vector3.New(0, 1, 10), (arg_239_1.time_ - 2) / var_242_13)
			end

			if arg_239_1.time_ >= 2 + var_242_13 and arg_239_1.time_ < 2 + var_242_13 + arg_242_0 then
				var_242_12.localPosition = Vector3.New(0, 1, 10)
			end

			local var_242_14 = arg_239_1.bgs_.F05_1.transform

			if 2.034 < arg_239_1.time_ and arg_239_1.time_ <= 2.034 + arg_242_0 then
				arg_239_1.var_.moveOldPosF05_1 = var_242_14.localPosition
			end

			local var_242_15 = 2.5

			if 2.034 <= arg_239_1.time_ and arg_239_1.time_ < 2.034 + var_242_15 then
				var_242_14.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosF05_1, Vector3.New(0, 1, 9.5), (arg_239_1.time_ - 2.034) / var_242_15)
			end

			if arg_239_1.time_ >= 2.034 + var_242_15 and arg_239_1.time_ < 2.034 + var_242_15 + arg_242_0 then
				var_242_14.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_242_16 = 4

			if 4 < arg_239_1.time_ and arg_239_1.time_ <= var_242_16 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			if arg_239_1.time_ >= var_242_16 + 0.534 and arg_239_1.time_ < var_242_16 + 0.534 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_242_19 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_239_1.bgmTxt_.text ~= var_242_19 and arg_239_1.bgmTxt_.text ~= "" then
						if arg_239_1.bgmTxt2_.text ~= "" then
							arg_239_1.bgmTxt_.text = arg_239_1.bgmTxt2_.text
						end

						arg_239_1.bgmTxt2_.text = var_242_19

						arg_239_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_239_1.bgmTxt_.text = var_242_19
						arg_239_1.bgmTxt2_.text = var_242_19
					end

					if arg_239_1.bgmTimer then
						arg_239_1.bgmTimer:Stop()

						arg_239_1.bgmTimer = nil
					end

					if arg_239_1.settingData.show_music_name == 1 then
						arg_239_1.musicController:SetSelectedState("show")
						arg_239_1.musicAnimator_:Play("open", 0, 0)

						if arg_239_1.settingData.music_time ~= 0 then
							arg_239_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_239_1.settingData.music_time), function()
								if arg_239_1 == nil or isNil(arg_239_1.bgmTxt_) then
									return
								end

								arg_239_1.musicController:SetSelectedState("hide")
								arg_239_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_20 = 4.3
			local var_242_21 = 0.95

			if 4.3 < arg_239_1.time_ and arg_239_1.time_ <= var_242_20 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_22 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_22:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_239_1.dialogCg_.alpha = arg_244_0
				end))
				var_242_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_23 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(114111059).content)

				arg_239_1.text_.text = var_242_23

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_25 = 38 <= 0 and var_242_21 or var_242_21 * (utf8.len(var_242_23) / 38)

				if (38 <= 0 and var_242_21 or var_242_21 * (utf8.len(var_242_23) / 38)) > 0 and var_242_21 < var_242_25 then
					arg_239_1.talkMaxDuration = var_242_25
					var_242_20 = var_242_20 + 0.3

					if var_242_25 + var_242_20 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_25 + var_242_20
					end
				end

				arg_239_1.text_.text = var_242_23
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_26 = var_242_20 + 0.3
			local var_242_27 = math.max(var_242_21, arg_239_1.talkMaxDuration)

			if var_242_20 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_26 + var_242_27 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_26) / var_242_27

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_26 + var_242_27 and arg_239_1.time_ < var_242_26 + var_242_27 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "F05_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "F05_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play114111060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 114111060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play114111061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.125

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(114111060).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 5 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 5)

				if (5 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 5)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play114111061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 114111061
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play114111062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 1.775

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(114111061).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 71 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 71)

				if (71 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 71)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play114111062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 114111062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play114111063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 1.525

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(114111062).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 61 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 61)

				if (61 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 61)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play114111063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 114111063
		arg_258_1.duration_ = 3.2

		local var_258_0 = {
			ja = 3.2,
			ko = 2.6,
			zh = 3,
			en = 3.133
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play114111064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if arg_258_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_261_0 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_258_1.stage_.transform)

				var_261_0.name = "1097ui_story"
				var_261_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.actors_["1097ui_story"] = var_261_0

				local var_261_1 = var_261_0:GetComponentInChildren(typeof(CharacterEffect))

				var_261_1.enabled = true

				local var_261_2 = GameObjectTools.GetOrAddComponent(var_261_0, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(false)
				end

				arg_258_1:ShowWeapon(var_261_1.transform, false)

				arg_258_1.var_["1097ui_story" .. "Animator"] = var_261_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_258_1.var_["1097ui_story" .. "Animator"].applyRootMotion = true
				arg_258_1.var_["1097ui_story" .. "LipSync"] = var_261_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_261_3 = arg_258_1.actors_["1097ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1097ui_story = var_261_3.localPosition
			end

			local var_261_4 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				var_261_3.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_258_1.time_ - 0) / var_261_4)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				var_261_3.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_261_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_3.position).x, (manager.ui.mainCamera.transform.position - var_261_3.position).y, (manager.ui.mainCamera.transform.position - var_261_3.position).z)
				var_261_3.localEulerAngles.z = 0
				var_261_3.localEulerAngles.x = 0
				var_261_3.localEulerAngles = var_261_3.localEulerAngles
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_261_5 = arg_258_1.actors_["1097ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1097ui_story == nil then
				arg_258_1.var_.characterEffect1097ui_story = var_261_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_6 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_6 and not isNil(var_261_5) then
				if arg_258_1.var_.characterEffect1097ui_story and not isNil(var_261_5) then
					arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_6 and arg_258_1.time_ < 0 + var_261_6 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.characterEffect1097ui_story then
				arg_258_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_261_8 = 0
			local var_261_9 = 0.175

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:GetWordFromCfg(114111063)
				local var_261_11 = arg_258_1:FormatText(var_261_10.content)

				arg_258_1.text_.text = var_261_11

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 7 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 7)

				if (7 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 7)) > 0 and var_261_9 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_11
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111063", "story_v_out_114111.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111063", "story_v_out_114111.awb") / 1000

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end

					if var_261_10.prefab_name ~= "" and arg_258_1.actors_[var_261_10.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_10.prefab_name].transform, "story_v_out_114111", "114111063", "story_v_out_114111.awb")

						arg_258_1:RecordAudio("114111063", var_261_15)
						arg_258_1:RecordAudio("114111063", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_114111", "114111063", "story_v_out_114111.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_114111", "114111063", "story_v_out_114111.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play114111064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 114111064
		arg_262_1.duration_ = 6.03

		local var_262_0 = {
			ja = 4.166,
			ko = 6.033,
			zh = 4.7,
			en = 5.533
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play114111065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) and arg_262_1.var_.characterEffect1097ui_story == nil then
				arg_262_1.var_.characterEffect1097ui_story = arg_262_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) then
				if arg_262_1.var_.characterEffect1097ui_story and not isNil(arg_262_1.actors_["1097ui_story"]) then
					arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1097ui_story"]) and arg_262_1.var_.characterEffect1097ui_story then
				arg_262_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_265_1 = "1184ui_story"

			if arg_262_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_265_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_262_1.stage_.transform)

				var_265_2.name = var_265_1
				var_265_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_[var_265_1] = var_265_2

				local var_265_3 = var_265_2:GetComponentInChildren(typeof(CharacterEffect))

				var_265_3.enabled = true

				local var_265_4 = GameObjectTools.GetOrAddComponent(var_265_2, typeof(DynamicBoneHelper))

				if var_265_4 then
					var_265_4:EnableDynamicBone(false)
				end

				arg_262_1:ShowWeapon(var_265_3.transform, false)

				arg_262_1.var_[var_265_1 .. "Animator"] = var_265_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_262_1.var_[var_265_1 .. "Animator"].applyRootMotion = true
				arg_262_1.var_[var_265_1 .. "LipSync"] = var_265_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_265_5 = arg_262_1.actors_["1184ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1184ui_story = var_265_5.localPosition

				arg_262_1:ShowWeapon(arg_262_1.var_["1184ui_story" .. "Animator"].transform, true)
			end

			local var_265_6 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_6 then
				var_265_5.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_262_1.time_ - 0) / var_265_6)
				var_265_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_5.position).x, (manager.ui.mainCamera.transform.position - var_265_5.position).y, (manager.ui.mainCamera.transform.position - var_265_5.position).z)
				var_265_5.localEulerAngles.z = 0
				var_265_5.localEulerAngles.x = 0
				var_265_5.localEulerAngles = var_265_5.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_6 and arg_262_1.time_ < 0 + var_265_6 + arg_265_0 then
				var_265_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_265_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_5.position).x, (manager.ui.mainCamera.transform.position - var_265_5.position).y, (manager.ui.mainCamera.transform.position - var_265_5.position).z)
				var_265_5.localEulerAngles.z = 0
				var_265_5.localEulerAngles.x = 0
				var_265_5.localEulerAngles = var_265_5.localEulerAngles
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_265_7 = arg_262_1.actors_["1184ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.characterEffect1184ui_story == nil then
				arg_262_1.var_.characterEffect1184ui_story = var_265_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_8 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_8 and not isNil(var_265_7) then
				if arg_262_1.var_.characterEffect1184ui_story and not isNil(var_265_7) then
					arg_262_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_8 and arg_262_1.time_ < 0 + var_265_8 + arg_265_0 and not isNil(var_265_7) and arg_262_1.var_.characterEffect1184ui_story then
				arg_262_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_265_10 = 0
			local var_265_11 = 0.7

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_12 = arg_262_1:GetWordFromCfg(114111064)
				local var_265_13 = arg_262_1:FormatText(var_265_12.content)

				arg_262_1.text_.text = var_265_13

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_15 = 28 <= 0 and var_265_11 or var_265_11 * (utf8.len(var_265_13) / 28)

				if (28 <= 0 and var_265_11 or var_265_11 * (utf8.len(var_265_13) / 28)) > 0 and var_265_11 < var_265_15 then
					arg_262_1.talkMaxDuration = var_265_15

					if var_265_15 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_15 + var_265_10
					end
				end

				arg_262_1.text_.text = var_265_13
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111064", "story_v_out_114111.awb") ~= 0 then
					local var_265_16 = manager.audio:GetVoiceLength("story_v_out_114111", "114111064", "story_v_out_114111.awb") / 1000

					if var_265_16 + var_265_10 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_16 + var_265_10
					end

					if var_265_12.prefab_name ~= "" and arg_262_1.actors_[var_265_12.prefab_name] ~= nil then
						local var_265_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_12.prefab_name].transform, "story_v_out_114111", "114111064", "story_v_out_114111.awb")

						arg_262_1:RecordAudio("114111064", var_265_17)
						arg_262_1:RecordAudio("114111064", var_265_17)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_114111", "114111064", "story_v_out_114111.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_114111", "114111064", "story_v_out_114111.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_18 = math.max(var_265_11, arg_262_1.talkMaxDuration)

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_18 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_10) / var_265_18

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_10 + var_265_18 and arg_262_1.time_ < var_265_10 + var_265_18 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play114111065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 114111065
		arg_266_1.duration_ = 6.7

		local var_266_0 = {
			ja = 3.333,
			ko = 6.7,
			zh = 4.633,
			en = 3.466
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play114111066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1184ui_story = arg_266_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).z)
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles = arg_266_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1184ui_story"].transform.position).z)
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1184ui_story"].transform.localEulerAngles = arg_266_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1097ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1097ui_story = var_269_1.localPosition

				arg_266_1:ShowWeapon(arg_266_1.var_["1097ui_story" .. "Animator"].transform, true)
			end

			local var_269_2 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 then
				var_269_1.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_2)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 then
				var_269_1.localPosition = Vector3.New(0, 100, 0)
				var_269_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_1.position).x, (manager.ui.mainCamera.transform.position - var_269_1.position).y, (manager.ui.mainCamera.transform.position - var_269_1.position).z)
				var_269_1.localEulerAngles.z = 0
				var_269_1.localEulerAngles.x = 0
				var_269_1.localEulerAngles = var_269_1.localEulerAngles
			end

			local var_269_3 = "1041ui_story"

			if arg_266_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_269_4 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_266_1.stage_.transform)

				var_269_4.name = var_269_3
				var_269_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_[var_269_3] = var_269_4

				local var_269_5 = var_269_4:GetComponentInChildren(typeof(CharacterEffect))

				var_269_5.enabled = true

				local var_269_6 = GameObjectTools.GetOrAddComponent(var_269_4, typeof(DynamicBoneHelper))

				if var_269_6 then
					var_269_6:EnableDynamicBone(false)
				end

				arg_266_1:ShowWeapon(var_269_5.transform, false)

				arg_266_1.var_[var_269_3 .. "Animator"] = var_269_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_266_1.var_[var_269_3 .. "Animator"].applyRootMotion = true
				arg_266_1.var_[var_269_3 .. "LipSync"] = var_269_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_269_7 = arg_266_1.actors_["1041ui_story"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1041ui_story = var_269_7.localPosition

				arg_266_1:ShowWeapon(arg_266_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_269_8 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_8 then
				var_269_7.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_266_1.time_ - 0) / var_269_8)
				var_269_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_7.position).x, (manager.ui.mainCamera.transform.position - var_269_7.position).y, (manager.ui.mainCamera.transform.position - var_269_7.position).z)
				var_269_7.localEulerAngles.z = 0
				var_269_7.localEulerAngles.x = 0
				var_269_7.localEulerAngles = var_269_7.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_8 and arg_266_1.time_ < 0 + var_269_8 + arg_269_0 then
				var_269_7.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_269_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_269_7.position).x, (manager.ui.mainCamera.transform.position - var_269_7.position).y, (manager.ui.mainCamera.transform.position - var_269_7.position).z)
				var_269_7.localEulerAngles.z = 0
				var_269_7.localEulerAngles.x = 0
				var_269_7.localEulerAngles = var_269_7.localEulerAngles
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_269_9 = arg_266_1.actors_["1041ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1041ui_story == nil then
				arg_266_1.var_.characterEffect1041ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_10 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_10 and not isNil(var_269_9) then
				if arg_266_1.var_.characterEffect1041ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_10 and arg_266_1.time_ < 0 + var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1041ui_story then
				arg_266_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_269_12 = 0
			local var_269_13 = 0.6

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_14 = arg_266_1:GetWordFromCfg(114111065)
				local var_269_15 = arg_266_1:FormatText(var_269_14.content)

				arg_266_1.text_.text = var_269_15

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_17 = 24 <= 0 and var_269_13 or var_269_13 * (utf8.len(var_269_15) / 24)

				if (24 <= 0 and var_269_13 or var_269_13 * (utf8.len(var_269_15) / 24)) > 0 and var_269_13 < var_269_17 then
					arg_266_1.talkMaxDuration = var_269_17

					if var_269_17 + var_269_12 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_17 + var_269_12
					end
				end

				arg_266_1.text_.text = var_269_15
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111065", "story_v_out_114111.awb") ~= 0 then
					local var_269_18 = manager.audio:GetVoiceLength("story_v_out_114111", "114111065", "story_v_out_114111.awb") / 1000

					if var_269_18 + var_269_12 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_18 + var_269_12
					end

					if var_269_14.prefab_name ~= "" and arg_266_1.actors_[var_269_14.prefab_name] ~= nil then
						local var_269_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_14.prefab_name].transform, "story_v_out_114111", "114111065", "story_v_out_114111.awb")

						arg_266_1:RecordAudio("114111065", var_269_19)
						arg_266_1:RecordAudio("114111065", var_269_19)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_114111", "114111065", "story_v_out_114111.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_114111", "114111065", "story_v_out_114111.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_20 = math.max(var_269_13, arg_266_1.talkMaxDuration)

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_20 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_12) / var_269_20

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_12 + var_269_20 and arg_266_1.time_ < var_269_12 + var_269_20 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play114111066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 114111066
		arg_270_1.duration_ = 5.17

		local var_270_0 = {
			ja = 5.166,
			ko = 5,
			zh = 4.366,
			en = 2.2
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play114111067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_273_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_270_1.stage_.transform)

				var_273_0.name = "1038ui_story"
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1038ui_story"] = var_273_0

				local var_273_1 = var_273_0:GetComponentInChildren(typeof(CharacterEffect))

				var_273_1.enabled = true

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_0, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end

				arg_270_1:ShowWeapon(var_273_1.transform, false)

				arg_270_1.var_["1038ui_story" .. "Animator"] = var_273_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_270_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_270_1.var_["1038ui_story" .. "LipSync"] = var_273_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_273_3 = arg_270_1.actors_["1038ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038ui_story = var_273_3.localPosition
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_3.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_270_1.time_ - 0) / var_273_4)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_273_5 = arg_270_1.actors_["1038ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1038ui_story == nil then
				arg_270_1.var_.characterEffect1038ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1038ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1038ui_story then
				arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_273_8 = arg_270_1.actors_["1041ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.characterEffect1041ui_story == nil then
				arg_270_1.var_.characterEffect1041ui_story = var_273_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_9 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_9 and not isNil(var_273_8) then
				if arg_270_1.var_.characterEffect1041ui_story and not isNil(var_273_8) then
					arg_270_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_9)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_9 and arg_270_1.time_ < 0 + var_273_9 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.characterEffect1041ui_story then
				arg_270_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_273_10 = 0
			local var_273_11 = 0.575

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_12 = arg_270_1:GetWordFromCfg(114111066)
				local var_273_13 = arg_270_1:FormatText(var_273_12.content)

				arg_270_1.text_.text = var_273_13

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_15 = 23 <= 0 and var_273_11 or var_273_11 * (utf8.len(var_273_13) / 23)

				if (23 <= 0 and var_273_11 or var_273_11 * (utf8.len(var_273_13) / 23)) > 0 and var_273_11 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_10
					end
				end

				arg_270_1.text_.text = var_273_13
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111066", "story_v_out_114111.awb") ~= 0 then
					local var_273_16 = manager.audio:GetVoiceLength("story_v_out_114111", "114111066", "story_v_out_114111.awb") / 1000

					if var_273_16 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_16 + var_273_10
					end

					if var_273_12.prefab_name ~= "" and arg_270_1.actors_[var_273_12.prefab_name] ~= nil then
						local var_273_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_12.prefab_name].transform, "story_v_out_114111", "114111066", "story_v_out_114111.awb")

						arg_270_1:RecordAudio("114111066", var_273_17)
						arg_270_1:RecordAudio("114111066", var_273_17)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_114111", "114111066", "story_v_out_114111.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_114111", "114111066", "story_v_out_114111.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_18 = math.max(var_273_11, arg_270_1.talkMaxDuration)

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_18 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_10) / var_273_18

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_10 + var_273_18 and arg_270_1.time_ < var_273_10 + var_273_18 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play114111067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 114111067
		arg_274_1.duration_ = 5.83

		local var_274_0 = {
			ja = 5.833,
			ko = 4.7,
			zh = 4.766,
			en = 4.733
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play114111068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_277_0 = arg_274_1.actors_["1041ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1041ui_story == nil then
				arg_274_1.var_.characterEffect1041ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_1 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 and not isNil(var_277_0) then
				if arg_274_1.var_.characterEffect1041ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1041ui_story then
				arg_274_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_277_3 = arg_274_1.actors_["1041ui_story"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1041ui_story = var_277_3.localPosition

				arg_274_1:ShowWeapon(arg_274_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_277_4 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				var_277_3.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_274_1.time_ - 0) / var_277_4)
				var_277_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_3.position).x, (manager.ui.mainCamera.transform.position - var_277_3.position).y, (manager.ui.mainCamera.transform.position - var_277_3.position).z)
				var_277_3.localEulerAngles.z = 0
				var_277_3.localEulerAngles.x = 0
				var_277_3.localEulerAngles = var_277_3.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				var_277_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_277_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_3.position).x, (manager.ui.mainCamera.transform.position - var_277_3.position).y, (manager.ui.mainCamera.transform.position - var_277_3.position).z)
				var_277_3.localEulerAngles.z = 0
				var_277_3.localEulerAngles.x = 0
				var_277_3.localEulerAngles = var_277_3.localEulerAngles
			end

			local var_277_5 = arg_274_1.actors_["1038ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1038ui_story == nil then
				arg_274_1.var_.characterEffect1038ui_story = var_277_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_6 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_6 and not isNil(var_277_5) then
				if arg_274_1.var_.characterEffect1038ui_story and not isNil(var_277_5) then
					arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_6)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_6 and arg_274_1.time_ < 0 + var_277_6 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1038ui_story then
				arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_277_7 = 0
			local var_277_8 = 0.525

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_9 = arg_274_1:GetWordFromCfg(114111067)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_12 = 21 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_10) / 21)

				if (21 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_10) / 21)) > 0 and var_277_8 < var_277_12 then
					arg_274_1.talkMaxDuration = var_277_12

					if var_277_12 + var_277_7 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_12 + var_277_7
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111067", "story_v_out_114111.awb") ~= 0 then
					local var_277_13 = manager.audio:GetVoiceLength("story_v_out_114111", "114111067", "story_v_out_114111.awb") / 1000

					if var_277_13 + var_277_7 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_7
					end

					if var_277_9.prefab_name ~= "" and arg_274_1.actors_[var_277_9.prefab_name] ~= nil then
						local var_277_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_9.prefab_name].transform, "story_v_out_114111", "114111067", "story_v_out_114111.awb")

						arg_274_1:RecordAudio("114111067", var_277_14)
						arg_274_1:RecordAudio("114111067", var_277_14)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_114111", "114111067", "story_v_out_114111.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_114111", "114111067", "story_v_out_114111.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_15 = math.max(var_277_8, arg_274_1.talkMaxDuration)

			if var_277_7 <= arg_274_1.time_ and arg_274_1.time_ < var_277_7 + var_277_15 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_7) / var_277_15

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_7 + var_277_15 and arg_274_1.time_ < var_277_7 + var_277_15 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play114111068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 114111068
		arg_278_1.duration_ = 9

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play114111069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_0 = 2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				local var_281_1 = Color.New(0, 0, 0)

				var_281_1.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.mask_.color = var_281_1
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				local var_281_2 = Color.New(0, 0, 0)

				var_281_2.a = 1
				arg_278_1.mask_.color = var_281_2
			end

			local var_281_3 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_4 = 2

			if var_281_3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_3 + var_281_4 then
				local var_281_5 = Color.New(0, 0, 0)

				var_281_5.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_3) / var_281_4)
				arg_278_1.mask_.color = var_281_5
			end

			if arg_278_1.time_ >= var_281_3 + var_281_4 and arg_278_1.time_ < var_281_3 + var_281_4 + arg_281_0 then
				local var_281_6 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_6.a = 0
				arg_278_1.mask_.color = var_281_6
			end

			local var_281_7 = arg_278_1.actors_["1041ui_story"].transform

			if 1.966 < arg_278_1.time_ and arg_278_1.time_ <= 1.966 + arg_281_0 then
				arg_278_1.var_.moveOldPos1041ui_story = var_281_7.localPosition

				arg_278_1:ShowWeapon(arg_278_1.var_["1041ui_story" .. "Animator"].transform, false)
			end

			local var_281_8 = 0.001

			if 1.966 <= arg_278_1.time_ and arg_278_1.time_ < 1.966 + var_281_8 then
				var_281_7.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 1.966) / var_281_8)
				var_281_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_7.position).x, (manager.ui.mainCamera.transform.position - var_281_7.position).y, (manager.ui.mainCamera.transform.position - var_281_7.position).z)
				var_281_7.localEulerAngles.z = 0
				var_281_7.localEulerAngles.x = 0
				var_281_7.localEulerAngles = var_281_7.localEulerAngles
			end

			if arg_278_1.time_ >= 1.966 + var_281_8 and arg_278_1.time_ < 1.966 + var_281_8 + arg_281_0 then
				var_281_7.localPosition = Vector3.New(0, 100, 0)
				var_281_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_7.position).x, (manager.ui.mainCamera.transform.position - var_281_7.position).y, (manager.ui.mainCamera.transform.position - var_281_7.position).z)
				var_281_7.localEulerAngles.z = 0
				var_281_7.localEulerAngles.x = 0
				var_281_7.localEulerAngles = var_281_7.localEulerAngles
			end

			local var_281_9 = arg_278_1.actors_["1038ui_story"].transform

			if 1.966 < arg_278_1.time_ and arg_278_1.time_ <= 1.966 + arg_281_0 then
				arg_278_1.var_.moveOldPos1038ui_story = var_281_9.localPosition
			end

			local var_281_10 = 0.001

			if 1.966 <= arg_278_1.time_ and arg_278_1.time_ < 1.966 + var_281_10 then
				var_281_9.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 1.966) / var_281_10)
				var_281_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_9.position).x, (manager.ui.mainCamera.transform.position - var_281_9.position).y, (manager.ui.mainCamera.transform.position - var_281_9.position).z)
				var_281_9.localEulerAngles.z = 0
				var_281_9.localEulerAngles.x = 0
				var_281_9.localEulerAngles = var_281_9.localEulerAngles
			end

			if arg_278_1.time_ >= 1.966 + var_281_10 and arg_278_1.time_ < 1.966 + var_281_10 + arg_281_0 then
				var_281_9.localPosition = Vector3.New(0, 100, 0)
				var_281_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_281_9.position).x, (manager.ui.mainCamera.transform.position - var_281_9.position).y, (manager.ui.mainCamera.transform.position - var_281_9.position).z)
				var_281_9.localEulerAngles.z = 0
				var_281_9.localEulerAngles.x = 0
				var_281_9.localEulerAngles = var_281_9.localEulerAngles
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_11 = 4
			local var_281_12 = 0.6

			if 4 < arg_278_1.time_ and arg_278_1.time_ <= var_281_11 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_13 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_13:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_14 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(114111068).content)

				arg_278_1.text_.text = var_281_14

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_16 = 24 <= 0 and var_281_12 or var_281_12 * (utf8.len(var_281_14) / 24)

				if (24 <= 0 and var_281_12 or var_281_12 * (utf8.len(var_281_14) / 24)) > 0 and var_281_12 < var_281_16 then
					arg_278_1.talkMaxDuration = var_281_16
					var_281_11 = var_281_11 + 0.3

					if var_281_16 + var_281_11 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_16 + var_281_11
					end
				end

				arg_278_1.text_.text = var_281_14
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_17 = var_281_11 + 0.3
			local var_281_18 = math.max(var_281_12, arg_278_1.talkMaxDuration)

			if var_281_11 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_17 + var_281_18 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_17) / var_281_18

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_17 + var_281_18 and arg_278_1.time_ < var_281_17 + var_281_18 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play114111069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 114111069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play114111070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.775

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_1 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(114111069).content)

				arg_284_1.text_.text = var_287_1

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_3 = 31 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 31)

				if (31 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_1) / 31)) > 0 and var_287_0 < var_287_3 then
					arg_284_1.talkMaxDuration = var_287_3

					if var_287_3 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_3 + 0
					end
				end

				arg_284_1.text_.text = var_287_1
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_4 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_4

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play114111070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 114111070
		arg_288_1.duration_ = 6.37

		local var_288_0 = {
			ja = 6.2,
			ko = 4.633,
			zh = 6.366,
			en = 4.6
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play114111071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.35

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:GetWordFromCfg(114111070)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 14 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 14)

				if (14 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 14)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111070", "story_v_out_114111.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111070", "story_v_out_114111.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_114111", "114111070", "story_v_out_114111.awb")

						arg_288_1:RecordAudio("114111070", var_291_6)
						arg_288_1:RecordAudio("114111070", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_114111", "114111070", "story_v_out_114111.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_114111", "114111070", "story_v_out_114111.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play114111071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 114111071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play114111072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.25

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(114111071).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 51 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 51)

				if (51 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 51)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play114111072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 114111072
		arg_296_1.duration_ = 13.3

		local var_296_0 = {
			ja = 7.966,
			ko = 9.4,
			zh = 13.3,
			en = 8.366
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play114111073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if arg_296_1.actors_["10006ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10006ui_story"))) then
				local var_299_0 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_296_1.stage_.transform)

				var_299_0.name = "10006ui_story"
				var_299_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["10006ui_story"] = var_299_0

				local var_299_1 = var_299_0:GetComponentInChildren(typeof(CharacterEffect))

				var_299_1.enabled = true

				local var_299_2 = GameObjectTools.GetOrAddComponent(var_299_0, typeof(DynamicBoneHelper))

				if var_299_2 then
					var_299_2:EnableDynamicBone(false)
				end

				arg_296_1:ShowWeapon(var_299_1.transform, false)

				arg_296_1.var_["10006ui_story" .. "Animator"] = var_299_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_296_1.var_["10006ui_story" .. "Animator"].applyRootMotion = true
				arg_296_1.var_["10006ui_story" .. "LipSync"] = var_299_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_299_3 = arg_296_1.actors_["10006ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10006ui_story = var_299_3.localPosition
			end

			local var_299_4 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_4 then
				var_299_3.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10006ui_story, Vector3.New(-0.7, -0.98, -5.65), (arg_296_1.time_ - 0) / var_299_4)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_4 and arg_296_1.time_ < 0 + var_299_4 + arg_299_0 then
				var_299_3.localPosition = Vector3.New(-0.7, -0.98, -5.65)
				var_299_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_3.position).x, (manager.ui.mainCamera.transform.position - var_299_3.position).y, (manager.ui.mainCamera.transform.position - var_299_3.position).z)
				var_299_3.localEulerAngles.z = 0
				var_299_3.localEulerAngles.x = 0
				var_299_3.localEulerAngles = var_299_3.localEulerAngles
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_299_5 = arg_296_1.actors_["10006ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect10006ui_story == nil then
				arg_296_1.var_.characterEffect10006ui_story = var_299_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_6 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.characterEffect10006ui_story and not isNil(var_299_5) then
					arg_296_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.characterEffect10006ui_story then
				arg_296_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_299_8 = 0
			local var_299_9 = 0.775

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_10 = arg_296_1:GetWordFromCfg(114111072)
				local var_299_11 = arg_296_1:FormatText(var_299_10.content)

				arg_296_1.text_.text = var_299_11

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 31 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 31)

				if (31 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 31)) > 0 and var_299_9 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_11
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111072", "story_v_out_114111.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111072", "story_v_out_114111.awb") / 1000

					if var_299_14 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_8
					end

					if var_299_10.prefab_name ~= "" and arg_296_1.actors_[var_299_10.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_10.prefab_name].transform, "story_v_out_114111", "114111072", "story_v_out_114111.awb")

						arg_296_1:RecordAudio("114111072", var_299_15)
						arg_296_1:RecordAudio("114111072", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_114111", "114111072", "story_v_out_114111.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_114111", "114111072", "story_v_out_114111.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_16 and arg_296_1.time_ < var_299_8 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play114111073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 114111073
		arg_300_1.duration_ = 13.3

		local var_300_0 = {
			ja = 13.3,
			ko = 9.5,
			zh = 7.466,
			en = 8.666
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play114111074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action5_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_303_0 = 0
			local var_303_1 = 0.725

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_2 = arg_300_1:GetWordFromCfg(114111073)
				local var_303_3 = arg_300_1:FormatText(var_303_2.content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 29 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 29)

				if (29 <= 0 and var_303_1 or var_303_1 * (utf8.len(var_303_3) / 29)) > 0 and var_303_1 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111073", "story_v_out_114111.awb") ~= 0 then
					local var_303_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111073", "story_v_out_114111.awb") / 1000

					if var_303_6 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_0
					end

					if var_303_2.prefab_name ~= "" and arg_300_1.actors_[var_303_2.prefab_name] ~= nil then
						local var_303_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_2.prefab_name].transform, "story_v_out_114111", "114111073", "story_v_out_114111.awb")

						arg_300_1:RecordAudio("114111073", var_303_7)
						arg_300_1:RecordAudio("114111073", var_303_7)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_114111", "114111073", "story_v_out_114111.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_114111", "114111073", "story_v_out_114111.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_8 and arg_300_1.time_ < var_303_0 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play114111074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 114111074
		arg_304_1.duration_ = 5.33

		local var_304_0 = {
			ja = 5.333,
			ko = 3.266,
			zh = 4.566,
			en = 4.9
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play114111075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action5_2")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_307_0 = 0
			local var_307_1 = 0.325

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_2 = arg_304_1:GetWordFromCfg(114111074)
				local var_307_3 = arg_304_1:FormatText(var_307_2.content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 13 <= 0 and var_307_1 or var_307_1 * (utf8.len(var_307_3) / 13)

				if (13 <= 0 and var_307_1 or var_307_1 * (utf8.len(var_307_3) / 13)) > 0 and var_307_1 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111074", "story_v_out_114111.awb") ~= 0 then
					local var_307_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111074", "story_v_out_114111.awb") / 1000

					if var_307_6 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_0
					end

					if var_307_2.prefab_name ~= "" and arg_304_1.actors_[var_307_2.prefab_name] ~= nil then
						local var_307_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_2.prefab_name].transform, "story_v_out_114111", "114111074", "story_v_out_114111.awb")

						arg_304_1:RecordAudio("114111074", var_307_7)
						arg_304_1:RecordAudio("114111074", var_307_7)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_114111", "114111074", "story_v_out_114111.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_114111", "114111074", "story_v_out_114111.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_8 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_8 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_8

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_8 and arg_304_1.time_ < var_307_0 + var_307_8 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play114111075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 114111075
		arg_308_1.duration_ = 3.07

		local var_308_0 = {
			ja = 1.999999999999,
			ko = 3.066,
			zh = 2.6,
			en = 2.266
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play114111076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1097ui_story = arg_308_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).z)
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles = arg_308_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_308_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1097ui_story"].transform.position).z)
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1097ui_story"].transform.localEulerAngles = arg_308_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_311_1 = arg_308_1.actors_["1097ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1097ui_story == nil then
				arg_308_1.var_.characterEffect1097ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect1097ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1097ui_story then
				arg_308_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_311_4 = arg_308_1.actors_["10006ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_4) and arg_308_1.var_.characterEffect10006ui_story == nil then
				arg_308_1.var_.characterEffect10006ui_story = var_311_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_5 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_5 and not isNil(var_311_4) then
				if arg_308_1.var_.characterEffect10006ui_story and not isNil(var_311_4) then
					arg_308_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_5)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_5 and arg_308_1.time_ < 0 + var_311_5 + arg_311_0 and not isNil(var_311_4) and arg_308_1.var_.characterEffect10006ui_story then
				arg_308_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_311_6 = 0
			local var_311_7 = 0.2

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_8 = arg_308_1:GetWordFromCfg(114111075)
				local var_311_9 = arg_308_1:FormatText(var_311_8.content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_11 = 8 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_9) / 8)

				if (8 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_9) / 8)) > 0 and var_311_7 < var_311_11 then
					arg_308_1.talkMaxDuration = var_311_11

					if var_311_11 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111075", "story_v_out_114111.awb") ~= 0 then
					local var_311_12 = manager.audio:GetVoiceLength("story_v_out_114111", "114111075", "story_v_out_114111.awb") / 1000

					if var_311_12 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_6
					end

					if var_311_8.prefab_name ~= "" and arg_308_1.actors_[var_311_8.prefab_name] ~= nil then
						local var_311_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_8.prefab_name].transform, "story_v_out_114111", "114111075", "story_v_out_114111.awb")

						arg_308_1:RecordAudio("114111075", var_311_13)
						arg_308_1:RecordAudio("114111075", var_311_13)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_114111", "114111075", "story_v_out_114111.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_114111", "114111075", "story_v_out_114111.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_14 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_14 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_14

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_14 and arg_308_1.time_ < var_311_6 + var_311_14 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play114111076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 114111076
		arg_312_1.duration_ = 9.43

		local var_312_0 = {
			ja = 7.9,
			ko = 7.3,
			zh = 9.433,
			en = 7.3
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play114111077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10006ui_story = arg_312_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).z)
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles = arg_312_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10006ui_story"].transform.position).z)
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10006ui_story"].transform.localEulerAngles = arg_312_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1097ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1097ui_story = var_315_1.localPosition
			end

			local var_315_2 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 then
				var_315_1.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_2)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 then
				var_315_1.localPosition = Vector3.New(0, 100, 0)
				var_315_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_1.position).x, (manager.ui.mainCamera.transform.position - var_315_1.position).y, (manager.ui.mainCamera.transform.position - var_315_1.position).z)
				var_315_1.localEulerAngles.z = 0
				var_315_1.localEulerAngles.x = 0
				var_315_1.localEulerAngles = var_315_1.localEulerAngles
			end

			local var_315_3 = 0
			local var_315_4 = 0.575

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_5 = arg_312_1:GetWordFromCfg(114111076)
				local var_315_6 = arg_312_1:FormatText(var_315_5.content)

				arg_312_1.text_.text = var_315_6

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_8 = 23 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_6) / 23)

				if (23 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_6) / 23)) > 0 and var_315_4 < var_315_8 then
					arg_312_1.talkMaxDuration = var_315_8

					if var_315_8 + var_315_3 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_8 + var_315_3
					end
				end

				arg_312_1.text_.text = var_315_6
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111076", "story_v_out_114111.awb") ~= 0 then
					local var_315_9 = manager.audio:GetVoiceLength("story_v_out_114111", "114111076", "story_v_out_114111.awb") / 1000

					if var_315_9 + var_315_3 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_3
					end

					if var_315_5.prefab_name ~= "" and arg_312_1.actors_[var_315_5.prefab_name] ~= nil then
						local var_315_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_5.prefab_name].transform, "story_v_out_114111", "114111076", "story_v_out_114111.awb")

						arg_312_1:RecordAudio("114111076", var_315_10)
						arg_312_1:RecordAudio("114111076", var_315_10)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_114111", "114111076", "story_v_out_114111.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_114111", "114111076", "story_v_out_114111.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_11 = math.max(var_315_4, arg_312_1.talkMaxDuration)

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_11 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_3) / var_315_11

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_3 + var_315_11 and arg_312_1.time_ < var_315_3 + var_315_11 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play114111077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 114111077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play114111078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.95

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(114111077).content)

				arg_316_1.text_.text = var_319_1

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_3 = 38 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 38)

				if (38 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 38)) > 0 and var_319_0 < var_319_3 then
					arg_316_1.talkMaxDuration = var_319_3

					if var_319_3 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_3 + 0
					end
				end

				arg_316_1.text_.text = var_319_1
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_4 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_4

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play114111078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 114111078
		arg_320_1.duration_ = 9.9

		local var_320_0 = {
			ja = 8.966,
			ko = 9.9,
			zh = 8.8,
			en = 8.133
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play114111079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1041ui_story = arg_320_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).z)
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles = arg_320_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_320_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1041ui_story"].transform.position).z)
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1041ui_story"].transform.localEulerAngles = arg_320_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_323_1 = arg_320_1.actors_["1041ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1041ui_story == nil then
				arg_320_1.var_.characterEffect1041ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect1041ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1041ui_story then
				arg_320_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_323_4 = 0
			local var_323_5 = 0.95

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(114111078)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_9 = 38 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 38)

				if (38 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 38)) > 0 and var_323_5 < var_323_9 then
					arg_320_1.talkMaxDuration = var_323_9

					if var_323_9 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_9 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111078", "story_v_out_114111.awb") ~= 0 then
					local var_323_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111078", "story_v_out_114111.awb") / 1000

					if var_323_10 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_4
					end

					if var_323_6.prefab_name ~= "" and arg_320_1.actors_[var_323_6.prefab_name] ~= nil then
						local var_323_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_6.prefab_name].transform, "story_v_out_114111", "114111078", "story_v_out_114111.awb")

						arg_320_1:RecordAudio("114111078", var_323_11)
						arg_320_1:RecordAudio("114111078", var_323_11)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_114111", "114111078", "story_v_out_114111.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_114111", "114111078", "story_v_out_114111.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_12 = math.max(var_323_5, arg_320_1.talkMaxDuration)

			if var_323_4 <= arg_320_1.time_ and arg_320_1.time_ < var_323_4 + var_323_12 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_4) / var_323_12

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_4 + var_323_12 and arg_320_1.time_ < var_323_4 + var_323_12 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play114111079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 114111079
		arg_324_1.duration_ = 2.5

		local var_324_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play114111080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1041ui_story"]) and arg_324_1.var_.characterEffect1041ui_story == nil then
				arg_324_1.var_.characterEffect1041ui_story = arg_324_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1041ui_story"]) then
				if arg_324_1.var_.characterEffect1041ui_story and not isNil(arg_324_1.actors_["1041ui_story"]) then
					arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1041ui_story"]) and arg_324_1.var_.characterEffect1041ui_story then
				arg_324_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_327_1 = arg_324_1.actors_["10006ui_story"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos10006ui_story = var_327_1.localPosition
			end

			local var_327_2 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 then
				var_327_1.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10006ui_story, Vector3.New(0.7, -0.98, -5.65), (arg_324_1.time_ - 0) / var_327_2)
				var_327_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_1.position).x, (manager.ui.mainCamera.transform.position - var_327_1.position).y, (manager.ui.mainCamera.transform.position - var_327_1.position).z)
				var_327_1.localEulerAngles.z = 0
				var_327_1.localEulerAngles.x = 0
				var_327_1.localEulerAngles = var_327_1.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 then
				var_327_1.localPosition = Vector3.New(0.7, -0.98, -5.65)
				var_327_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_1.position).x, (manager.ui.mainCamera.transform.position - var_327_1.position).y, (manager.ui.mainCamera.transform.position - var_327_1.position).z)
				var_327_1.localEulerAngles.z = 0
				var_327_1.localEulerAngles.x = 0
				var_327_1.localEulerAngles = var_327_1.localEulerAngles
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_327_3 = arg_324_1.actors_["10006ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_3) and arg_324_1.var_.characterEffect10006ui_story == nil then
				arg_324_1.var_.characterEffect10006ui_story = var_327_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_4 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 and not isNil(var_327_3) then
				if arg_324_1.var_.characterEffect10006ui_story and not isNil(var_327_3) then
					arg_324_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 and not isNil(var_327_3) and arg_324_1.var_.characterEffect10006ui_story then
				arg_324_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_327_6 = 0
			local var_327_7 = 0.175

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_8 = arg_324_1:GetWordFromCfg(114111079)
				local var_327_9 = arg_324_1:FormatText(var_327_8.content)

				arg_324_1.text_.text = var_327_9

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 7 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 7)

				if (7 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 7)) > 0 and var_327_7 < var_327_11 then
					arg_324_1.talkMaxDuration = var_327_11

					if var_327_11 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_9
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111079", "story_v_out_114111.awb") ~= 0 then
					local var_327_12 = manager.audio:GetVoiceLength("story_v_out_114111", "114111079", "story_v_out_114111.awb") / 1000

					if var_327_12 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_6
					end

					if var_327_8.prefab_name ~= "" and arg_324_1.actors_[var_327_8.prefab_name] ~= nil then
						local var_327_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_8.prefab_name].transform, "story_v_out_114111", "114111079", "story_v_out_114111.awb")

						arg_324_1:RecordAudio("114111079", var_327_13)
						arg_324_1:RecordAudio("114111079", var_327_13)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_114111", "114111079", "story_v_out_114111.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_114111", "114111079", "story_v_out_114111.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play114111080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 114111080
		arg_328_1.duration_ = 11.13

		local var_328_0 = {
			ja = 11.133,
			ko = 9.8,
			zh = 8.5,
			en = 8
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play114111081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_331_0 = arg_328_1.actors_["1041ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1041ui_story == nil then
				arg_328_1.var_.characterEffect1041ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_1 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_1 and not isNil(var_331_0) then
				if arg_328_1.var_.characterEffect1041ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_1 and arg_328_1.time_ < 0 + var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1041ui_story then
				arg_328_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_331_3 = arg_328_1.actors_["10006ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_3) and arg_328_1.var_.characterEffect10006ui_story == nil then
				arg_328_1.var_.characterEffect10006ui_story = var_331_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_4 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 and not isNil(var_331_3) then
				if arg_328_1.var_.characterEffect10006ui_story and not isNil(var_331_3) then
					arg_328_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0) / var_331_4)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 and not isNil(var_331_3) and arg_328_1.var_.characterEffect10006ui_story then
				arg_328_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_331_5 = 0
			local var_331_6 = 1.075

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_7 = arg_328_1:GetWordFromCfg(114111080)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_10 = 43 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 43)

				if (43 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 43)) > 0 and var_331_6 < var_331_10 then
					arg_328_1.talkMaxDuration = var_331_10

					if var_331_10 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_5
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111080", "story_v_out_114111.awb") ~= 0 then
					local var_331_11 = manager.audio:GetVoiceLength("story_v_out_114111", "114111080", "story_v_out_114111.awb") / 1000

					if var_331_11 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_5
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_114111", "114111080", "story_v_out_114111.awb")

						arg_328_1:RecordAudio("114111080", var_331_12)
						arg_328_1:RecordAudio("114111080", var_331_12)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_114111", "114111080", "story_v_out_114111.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_114111", "114111080", "story_v_out_114111.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_13 = math.max(var_331_6, arg_328_1.talkMaxDuration)

			if var_331_5 <= arg_328_1.time_ and arg_328_1.time_ < var_331_5 + var_331_13 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_5) / var_331_13

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_5 + var_331_13 and arg_328_1.time_ < var_331_5 + var_331_13 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play114111081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 114111081
		arg_332_1.duration_ = 12.53

		local var_332_0 = {
			ja = 8.7,
			ko = 12.533,
			zh = 8.433,
			en = 9.6
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play114111082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10006ui_story = arg_332_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).z)
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles = arg_332_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10006ui_story"].transform.position).z)
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10006ui_story"].transform.localEulerAngles = arg_332_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["1041ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1041ui_story = var_335_1.localPosition
			end

			local var_335_2 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 then
				var_335_1.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_2)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 then
				var_335_1.localPosition = Vector3.New(0, 100, 0)
				var_335_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_1.position).x, (manager.ui.mainCamera.transform.position - var_335_1.position).y, (manager.ui.mainCamera.transform.position - var_335_1.position).z)
				var_335_1.localEulerAngles.z = 0
				var_335_1.localEulerAngles.x = 0
				var_335_1.localEulerAngles = var_335_1.localEulerAngles
			end

			local var_335_3 = arg_332_1.actors_["1038ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1038ui_story = var_335_3.localPosition
			end

			local var_335_4 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				var_335_3.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1038ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_332_1.time_ - 0) / var_335_4)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				var_335_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_335_5 = arg_332_1.actors_["1038ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect1038ui_story == nil then
				arg_332_1.var_.characterEffect1038ui_story = var_335_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_6 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_6 and not isNil(var_335_5) then
				if arg_332_1.var_.characterEffect1038ui_story and not isNil(var_335_5) then
					arg_332_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_6 and arg_332_1.time_ < 0 + var_335_6 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect1038ui_story then
				arg_332_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_335_8 = 0
			local var_335_9 = 1.15

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_10 = arg_332_1:GetWordFromCfg(114111081)
				local var_335_11 = arg_332_1:FormatText(var_335_10.content)

				arg_332_1.text_.text = var_335_11

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 46 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 46)

				if (46 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 46)) > 0 and var_335_9 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_8
					end
				end

				arg_332_1.text_.text = var_335_11
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111081", "story_v_out_114111.awb") ~= 0 then
					local var_335_14 = manager.audio:GetVoiceLength("story_v_out_114111", "114111081", "story_v_out_114111.awb") / 1000

					if var_335_14 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_8
					end

					if var_335_10.prefab_name ~= "" and arg_332_1.actors_[var_335_10.prefab_name] ~= nil then
						local var_335_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_10.prefab_name].transform, "story_v_out_114111", "114111081", "story_v_out_114111.awb")

						arg_332_1:RecordAudio("114111081", var_335_15)
						arg_332_1:RecordAudio("114111081", var_335_15)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_114111", "114111081", "story_v_out_114111.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_114111", "114111081", "story_v_out_114111.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_9, arg_332_1.talkMaxDuration)

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_8) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_8 + var_335_16 and arg_332_1.time_ < var_335_8 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play114111082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 114111082
		arg_336_1.duration_ = 11.83

		local var_336_0 = {
			ja = 9.8,
			ko = 9.933,
			zh = 9.466,
			en = 11.833
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play114111083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_339_0 = 0
			local var_339_1 = 1.15

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_2 = arg_336_1:GetWordFromCfg(114111082)
				local var_339_3 = arg_336_1:FormatText(var_339_2.content)

				arg_336_1.text_.text = var_339_3

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 46 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 46)

				if (46 <= 0 and var_339_1 or var_339_1 * (utf8.len(var_339_3) / 46)) > 0 and var_339_1 < var_339_5 then
					arg_336_1.talkMaxDuration = var_339_5

					if var_339_5 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_3
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111082", "story_v_out_114111.awb") ~= 0 then
					local var_339_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111082", "story_v_out_114111.awb") / 1000

					if var_339_6 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_0
					end

					if var_339_2.prefab_name ~= "" and arg_336_1.actors_[var_339_2.prefab_name] ~= nil then
						local var_339_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_2.prefab_name].transform, "story_v_out_114111", "114111082", "story_v_out_114111.awb")

						arg_336_1:RecordAudio("114111082", var_339_7)
						arg_336_1:RecordAudio("114111082", var_339_7)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_114111", "114111082", "story_v_out_114111.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_114111", "114111082", "story_v_out_114111.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_8 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_8 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_8

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_8 and arg_336_1.time_ < var_339_0 + var_339_8 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play114111083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 114111083
		arg_340_1.duration_ = 5.17

		local var_340_0 = {
			ja = 5.166,
			ko = 3.5,
			zh = 3.166,
			en = 4.033
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play114111084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1097ui_story = arg_340_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).z)
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles = arg_340_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0.7, -0.54, -6.3)
				arg_340_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1097ui_story"].transform.position).z)
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1097ui_story"].transform.localEulerAngles = arg_340_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_343_1 = arg_340_1.actors_["1097ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1097ui_story == nil then
				arg_340_1.var_.characterEffect1097ui_story = var_343_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_2 and not isNil(var_343_1) then
				if arg_340_1.var_.characterEffect1097ui_story and not isNil(var_343_1) then
					arg_340_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_2 and arg_340_1.time_ < 0 + var_343_2 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1097ui_story then
				arg_340_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_343_4 = arg_340_1.actors_["1038ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_4) and arg_340_1.var_.characterEffect1038ui_story == nil then
				arg_340_1.var_.characterEffect1038ui_story = var_343_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_5 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_5 and not isNil(var_343_4) then
				if arg_340_1.var_.characterEffect1038ui_story and not isNil(var_343_4) then
					arg_340_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_5)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_5 and arg_340_1.time_ < 0 + var_343_5 + arg_343_0 and not isNil(var_343_4) and arg_340_1.var_.characterEffect1038ui_story then
				arg_340_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_343_6 = 0
			local var_343_7 = 0.325

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_8 = arg_340_1:GetWordFromCfg(114111083)
				local var_343_9 = arg_340_1:FormatText(var_343_8.content)

				arg_340_1.text_.text = var_343_9

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 13 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_9) / 13)

				if (13 <= 0 and var_343_7 or var_343_7 * (utf8.len(var_343_9) / 13)) > 0 and var_343_7 < var_343_11 then
					arg_340_1.talkMaxDuration = var_343_11

					if var_343_11 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_9
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111083", "story_v_out_114111.awb") ~= 0 then
					local var_343_12 = manager.audio:GetVoiceLength("story_v_out_114111", "114111083", "story_v_out_114111.awb") / 1000

					if var_343_12 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_12 + var_343_6
					end

					if var_343_8.prefab_name ~= "" and arg_340_1.actors_[var_343_8.prefab_name] ~= nil then
						local var_343_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_8.prefab_name].transform, "story_v_out_114111", "114111083", "story_v_out_114111.awb")

						arg_340_1:RecordAudio("114111083", var_343_13)
						arg_340_1:RecordAudio("114111083", var_343_13)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_114111", "114111083", "story_v_out_114111.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_114111", "114111083", "story_v_out_114111.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_14 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_14 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_14

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_14 and arg_340_1.time_ < var_343_6 + var_343_14 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play114111084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 114111084
		arg_344_1.duration_ = 3.27

		local var_344_0 = {
			ja = 3.266,
			ko = 2.166,
			zh = 1.566,
			en = 1.366
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play114111085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1097ui_story"]) and arg_344_1.var_.characterEffect1097ui_story == nil then
				arg_344_1.var_.characterEffect1097ui_story = arg_344_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1097ui_story"]) then
				if arg_344_1.var_.characterEffect1097ui_story and not isNil(arg_344_1.actors_["1097ui_story"]) then
					arg_344_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_0)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1097ui_story"]) and arg_344_1.var_.characterEffect1097ui_story then
				arg_344_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_347_1 = 0
			local var_347_2 = 0.075

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(114111084)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_6 = 3 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 3)

				if (3 <= 0 and var_347_2 or var_347_2 * (utf8.len(var_347_4) / 3)) > 0 and var_347_2 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_1
					end
				end

				arg_344_1.text_.text = var_347_4
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111084", "story_v_out_114111.awb") ~= 0 then
					local var_347_7 = manager.audio:GetVoiceLength("story_v_out_114111", "114111084", "story_v_out_114111.awb") / 1000

					if var_347_7 + var_347_1 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_1
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_114111", "114111084", "story_v_out_114111.awb")

						arg_344_1:RecordAudio("114111084", var_347_8)
						arg_344_1:RecordAudio("114111084", var_347_8)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_114111", "114111084", "story_v_out_114111.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_114111", "114111084", "story_v_out_114111.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_9 = math.max(var_347_2, arg_344_1.talkMaxDuration)

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_9 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_1) / var_347_9

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_1 + var_347_9 and arg_344_1.time_ < var_347_1 + var_347_9 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play114111085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 114111085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play114111086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1038ui_story = arg_348_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_351_0 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 then
				arg_348_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 0) / var_351_0)
				arg_348_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).z)
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles = arg_348_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 then
				arg_348_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_348_1.actors_["1038ui_story"].transform.position).z)
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_348_1.actors_["1038ui_story"].transform.localEulerAngles = arg_348_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_351_1 = arg_348_1.actors_["1097ui_story"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1097ui_story = var_351_1.localPosition
			end

			local var_351_2 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_2 then
				var_351_1.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 0) / var_351_2)
				var_351_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_1.position).x, (manager.ui.mainCamera.transform.position - var_351_1.position).y, (manager.ui.mainCamera.transform.position - var_351_1.position).z)
				var_351_1.localEulerAngles.z = 0
				var_351_1.localEulerAngles.x = 0
				var_351_1.localEulerAngles = var_351_1.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_2 and arg_348_1.time_ < 0 + var_351_2 + arg_351_0 then
				var_351_1.localPosition = Vector3.New(0, 100, 0)
				var_351_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_1.position).x, (manager.ui.mainCamera.transform.position - var_351_1.position).y, (manager.ui.mainCamera.transform.position - var_351_1.position).z)
				var_351_1.localEulerAngles.z = 0
				var_351_1.localEulerAngles.x = 0
				var_351_1.localEulerAngles = var_351_1.localEulerAngles
			end

			local var_351_3 = 0
			local var_351_4 = 0.675

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_3 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_5 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(114111085).content)

				arg_348_1.text_.text = var_351_5

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_7 = 27 <= 0 and var_351_4 or var_351_4 * (utf8.len(var_351_5) / 27)

				if (27 <= 0 and var_351_4 or var_351_4 * (utf8.len(var_351_5) / 27)) > 0 and var_351_4 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_3 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_3
					end
				end

				arg_348_1.text_.text = var_351_5
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_4, arg_348_1.talkMaxDuration)

			if var_351_3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_3 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_3) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_3 + var_351_8 and arg_348_1.time_ < var_351_3 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play114111086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 114111086
		arg_352_1.duration_ = 10.1

		local var_352_0 = {
			ja = 7.466,
			ko = 6.533,
			zh = 6.7,
			en = 10.1
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
				arg_352_0:Play114111087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1184ui_story = arg_352_1.actors_["1184ui_story"].transform.localPosition

				arg_352_1:ShowWeapon(arg_352_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_355_0 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 then
				arg_352_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_352_1.time_ - 0) / var_355_0)
				arg_352_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).z)
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles = arg_352_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 then
				arg_352_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_352_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["1184ui_story"].transform.position).z)
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["1184ui_story"].transform.localEulerAngles = arg_352_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_355_1 = arg_352_1.actors_["1184ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1184ui_story == nil then
				arg_352_1.var_.characterEffect1184ui_story = var_355_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_2 and not isNil(var_355_1) then
				if arg_352_1.var_.characterEffect1184ui_story and not isNil(var_355_1) then
					arg_352_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_2 and arg_352_1.time_ < 0 + var_355_2 + arg_355_0 and not isNil(var_355_1) and arg_352_1.var_.characterEffect1184ui_story then
				arg_352_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_355_4 = 0
			local var_355_5 = 0.725

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_4 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_6 = arg_352_1:GetWordFromCfg(114111086)
				local var_355_7 = arg_352_1:FormatText(var_355_6.content)

				arg_352_1.text_.text = var_355_7

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_9 = 29 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 29)

				if (29 <= 0 and var_355_5 or var_355_5 * (utf8.len(var_355_7) / 29)) > 0 and var_355_5 < var_355_9 then
					arg_352_1.talkMaxDuration = var_355_9

					if var_355_9 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_9 + var_355_4
					end
				end

				arg_352_1.text_.text = var_355_7
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111086", "story_v_out_114111.awb") ~= 0 then
					local var_355_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111086", "story_v_out_114111.awb") / 1000

					if var_355_10 + var_355_4 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_10 + var_355_4
					end

					if var_355_6.prefab_name ~= "" and arg_352_1.actors_[var_355_6.prefab_name] ~= nil then
						local var_355_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_6.prefab_name].transform, "story_v_out_114111", "114111086", "story_v_out_114111.awb")

						arg_352_1:RecordAudio("114111086", var_355_11)
						arg_352_1:RecordAudio("114111086", var_355_11)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_114111", "114111086", "story_v_out_114111.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_114111", "114111086", "story_v_out_114111.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_12 = math.max(var_355_5, arg_352_1.talkMaxDuration)

			if var_355_4 <= arg_352_1.time_ and arg_352_1.time_ < var_355_4 + var_355_12 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_4) / var_355_12

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_4 + var_355_12 and arg_352_1.time_ < var_355_4 + var_355_12 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play114111087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 114111087
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play114111088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1184ui_story = arg_356_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_356_1.time_ - 0) / var_359_0)
				arg_356_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).z)
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles = arg_356_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_356_1.actors_["1184ui_story"].transform.position).z)
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_356_1.actors_["1184ui_story"].transform.localEulerAngles = arg_356_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_359_1 = 0
			local var_359_2 = 0.475

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(114111087).content)

				arg_356_1.text_.text = var_359_3

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 19 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 19)

				if (19 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_3) / 19)) > 0 and var_359_2 < var_359_5 then
					arg_356_1.talkMaxDuration = var_359_5

					if var_359_5 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_3
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_6 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_6 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_6

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_6 and arg_356_1.time_ < var_359_1 + var_359_6 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play114111088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 114111088
		arg_360_1.duration_ = 13.63

		local var_360_0 = {
			ja = 13.633,
			ko = 8.033,
			zh = 8.233,
			en = 6.833
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
				arg_360_0:Play114111089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10006ui_story = arg_360_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_363_0 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 then
				arg_360_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10006ui_story, Vector3.New(0, -0.98, -5.65), (arg_360_1.time_ - 0) / var_363_0)
				arg_360_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).z)
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles = arg_360_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 then
				arg_360_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, -0.98, -5.65)
				arg_360_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_360_1.actors_["10006ui_story"].transform.position).z)
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_360_1.actors_["10006ui_story"].transform.localEulerAngles = arg_360_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action1_1")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_363_1 = arg_360_1.actors_["10006ui_story"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect10006ui_story == nil then
				arg_360_1.var_.characterEffect10006ui_story = var_363_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_2 = 0.2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_2 and not isNil(var_363_1) then
				if arg_360_1.var_.characterEffect10006ui_story and not isNil(var_363_1) then
					arg_360_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_2 and arg_360_1.time_ < 0 + var_363_2 + arg_363_0 and not isNil(var_363_1) and arg_360_1.var_.characterEffect10006ui_story then
				arg_360_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_363_4 = 0
			local var_363_5 = 0.85

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_4 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_6 = arg_360_1:GetWordFromCfg(114111088)
				local var_363_7 = arg_360_1:FormatText(var_363_6.content)

				arg_360_1.text_.text = var_363_7

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_9 = 34 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 34)

				if (34 <= 0 and var_363_5 or var_363_5 * (utf8.len(var_363_7) / 34)) > 0 and var_363_5 < var_363_9 then
					arg_360_1.talkMaxDuration = var_363_9

					if var_363_9 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_4
					end
				end

				arg_360_1.text_.text = var_363_7
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111088", "story_v_out_114111.awb") ~= 0 then
					local var_363_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111088", "story_v_out_114111.awb") / 1000

					if var_363_10 + var_363_4 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_10 + var_363_4
					end

					if var_363_6.prefab_name ~= "" and arg_360_1.actors_[var_363_6.prefab_name] ~= nil then
						local var_363_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_6.prefab_name].transform, "story_v_out_114111", "114111088", "story_v_out_114111.awb")

						arg_360_1:RecordAudio("114111088", var_363_11)
						arg_360_1:RecordAudio("114111088", var_363_11)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_114111", "114111088", "story_v_out_114111.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_114111", "114111088", "story_v_out_114111.awb")
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
				actorName = "10006ui_story",
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
	Play114111089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 114111089
		arg_364_1.duration_ = 14.63

		local var_364_0 = {
			ja = 14.633,
			ko = 11.3,
			zh = 8.6,
			en = 10.1
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play114111090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_367_0 = 0
			local var_367_1 = 1.05

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(114111089)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 42 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 42)

				if (42 <= 0 and var_367_1 or var_367_1 * (utf8.len(var_367_3) / 42)) > 0 and var_367_1 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111089", "story_v_out_114111.awb") ~= 0 then
					local var_367_6 = manager.audio:GetVoiceLength("story_v_out_114111", "114111089", "story_v_out_114111.awb") / 1000

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end

					if var_367_2.prefab_name ~= "" and arg_364_1.actors_[var_367_2.prefab_name] ~= nil then
						local var_367_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_2.prefab_name].transform, "story_v_out_114111", "114111089", "story_v_out_114111.awb")

						arg_364_1:RecordAudio("114111089", var_367_7)
						arg_364_1:RecordAudio("114111089", var_367_7)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_114111", "114111089", "story_v_out_114111.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_114111", "114111089", "story_v_out_114111.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play114111090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 114111090
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play114111091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["10006ui_story"]) and arg_368_1.var_.characterEffect10006ui_story == nil then
				arg_368_1.var_.characterEffect10006ui_story = arg_368_1.actors_["10006ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["10006ui_story"]) then
				if arg_368_1.var_.characterEffect10006ui_story and not isNil(arg_368_1.actors_["10006ui_story"]) then
					arg_368_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_368_1.var_.characterEffect10006ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_368_1.time_ - 0) / var_371_0)
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["10006ui_story"]) and arg_368_1.var_.characterEffect10006ui_story then
				arg_368_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_368_1.var_.characterEffect10006ui_story.fillRatio = 0.5
			end

			local var_371_1 = 0
			local var_371_2 = 0.575

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_1 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(114111090).content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)

				if (23 <= 0 and var_371_2 or var_371_2 * (utf8.len(var_371_3) / 23)) > 0 and var_371_2 < var_371_5 then
					arg_368_1.talkMaxDuration = var_371_5

					if var_371_5 + var_371_1 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + var_371_1
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_6 = math.max(var_371_2, arg_368_1.talkMaxDuration)

			if var_371_1 <= arg_368_1.time_ and arg_368_1.time_ < var_371_1 + var_371_6 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_1) / var_371_6

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_1 + var_371_6 and arg_368_1.time_ < var_371_1 + var_371_6 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play114111091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 114111091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play114111092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos10006ui_story = arg_372_1.actors_["10006ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["10006ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos10006ui_story, Vector3.New(0, 100, 0), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).z)
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles = arg_372_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["10006ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_372_1.actors_["10006ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10006ui_story"].transform.position).z)
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["10006ui_story"].transform.localEulerAngles = arg_372_1.actors_["10006ui_story"].transform.localEulerAngles
			end

			local var_375_1 = 0
			local var_375_2 = 0.775

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(114111091).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 31 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 31)

				if (31 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 31)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play114111092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 114111092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play114111093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.175

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(114111092).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 7 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 7)

				if (7 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 7)) > 0 and var_379_0 < var_379_3 then
					arg_376_1.talkMaxDuration = var_379_3

					if var_379_3 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_3 + 0
					end
				end

				arg_376_1.text_.text = var_379_1
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_4 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_4

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play114111093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 114111093
		arg_380_1.duration_ = 6.8

		local var_380_0 = {
			ja = 3.633,
			ko = 5.033,
			zh = 5.6,
			en = 6.8
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play114111094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1184ui_story = arg_380_1.actors_["1184ui_story"].transform.localPosition

				arg_380_1:ShowWeapon(arg_380_1.var_["1184ui_story" .. "Animator"].transform, false)
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1184ui_story, Vector3.New(0, -0.97, -6), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).z)
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles = arg_380_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_380_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1184ui_story"].transform.position).z)
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1184ui_story"].transform.localEulerAngles = arg_380_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_383_1 = arg_380_1.actors_["1184ui_story"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1184ui_story == nil then
				arg_380_1.var_.characterEffect1184ui_story = var_383_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_2 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_2 and not isNil(var_383_1) then
				if arg_380_1.var_.characterEffect1184ui_story and not isNil(var_383_1) then
					arg_380_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= 0 + var_383_2 and arg_380_1.time_ < 0 + var_383_2 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect1184ui_story then
				arg_380_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_383_4 = 0
			local var_383_5 = 0.5

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_4 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_6 = arg_380_1:GetWordFromCfg(114111093)
				local var_383_7 = arg_380_1:FormatText(var_383_6.content)

				arg_380_1.text_.text = var_383_7

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_9 = 20 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 20)

				if (20 <= 0 and var_383_5 or var_383_5 * (utf8.len(var_383_7) / 20)) > 0 and var_383_5 < var_383_9 then
					arg_380_1.talkMaxDuration = var_383_9

					if var_383_9 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_9 + var_383_4
					end
				end

				arg_380_1.text_.text = var_383_7
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111093", "story_v_out_114111.awb") ~= 0 then
					local var_383_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111093", "story_v_out_114111.awb") / 1000

					if var_383_10 + var_383_4 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_10 + var_383_4
					end

					if var_383_6.prefab_name ~= "" and arg_380_1.actors_[var_383_6.prefab_name] ~= nil then
						local var_383_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_6.prefab_name].transform, "story_v_out_114111", "114111093", "story_v_out_114111.awb")

						arg_380_1:RecordAudio("114111093", var_383_11)
						arg_380_1:RecordAudio("114111093", var_383_11)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_114111", "114111093", "story_v_out_114111.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_114111", "114111093", "story_v_out_114111.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_12 = math.max(var_383_5, arg_380_1.talkMaxDuration)

			if var_383_4 <= arg_380_1.time_ and arg_380_1.time_ < var_383_4 + var_383_12 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_4) / var_383_12

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_4 + var_383_12 and arg_380_1.time_ < var_383_4 + var_383_12 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play114111094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 114111094
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play114111095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1184ui_story = arg_384_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).z)
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles = arg_384_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_384_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1184ui_story"].transform.position).z)
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1184ui_story"].transform.localEulerAngles = arg_384_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_387_1 = 0
			local var_387_2 = 1.35

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_3 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(114111094).content)

				arg_384_1.text_.text = var_387_3

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 54 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 54)

				if (54 <= 0 and var_387_2 or var_387_2 * (utf8.len(var_387_3) / 54)) > 0 and var_387_2 < var_387_5 then
					arg_384_1.talkMaxDuration = var_387_5

					if var_387_5 + var_387_1 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + var_387_1
					end
				end

				arg_384_1.text_.text = var_387_3
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_6 = math.max(var_387_2, arg_384_1.talkMaxDuration)

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_6 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_1) / var_387_6

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_1 + var_387_6 and arg_384_1.time_ < var_387_1 + var_387_6 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
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
	Play114111095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 114111095
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play114111096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_391_0 = 1.5

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				local var_391_1, var_391_2 = math.modf((arg_388_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_391_2 * 0.13, var_391_2 * 0.13, var_391_2 * 0.13) + arg_388_1.var_.shakeOldPos
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				manager.ui.mainCamera.transform.localPosition = arg_388_1.var_.shakeOldPos
			end

			local var_391_3 = 0

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_3 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			if arg_388_1.time_ >= var_391_3 + 1.5 and arg_388_1.time_ < var_391_3 + 1.5 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:AudioAction("play", "effect", "se_story_11", "se_story_11_roar", "")
			end

			local var_391_5 = 0
			local var_391_6 = 0.125

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_7 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(114111095).content)

				arg_388_1.text_.text = var_391_7

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_9 = 5 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_7) / 5)

				if (5 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_7) / 5)) > 0 and var_391_6 < var_391_9 then
					arg_388_1.talkMaxDuration = var_391_9

					if var_391_9 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_9 + var_391_5
					end
				end

				arg_388_1.text_.text = var_391_7
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_10 = math.max(var_391_6, arg_388_1.talkMaxDuration)

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_10 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_5) / var_391_10

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_5 + var_391_10 and arg_388_1.time_ < var_391_5 + var_391_10 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play114111096 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 114111096
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play114111097(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.15

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(114111096).content)

				arg_392_1.text_.text = var_395_1

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_3 = 6 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 6)

				if (6 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_1) / 6)) > 0 and var_395_0 < var_395_3 then
					arg_392_1.talkMaxDuration = var_395_3

					if var_395_3 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_3 + 0
					end
				end

				arg_392_1.text_.text = var_395_1
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_4 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_4

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play114111097 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 114111097
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play114111098(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 1.075

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(114111097).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 43 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 43)

				if (43 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 43)) > 0 and var_399_0 < var_399_3 then
					arg_396_1.talkMaxDuration = var_399_3

					if var_399_3 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_3 + 0
					end
				end

				arg_396_1.text_.text = var_399_1
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_4 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_4 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_4

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_4 and arg_396_1.time_ < 0 + var_399_4 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play114111098 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 114111098
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play114111099(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 1.675

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(114111098).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 67 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 67)

				if (67 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 67)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play114111099 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 114111099
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play114111100(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.325

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(114111099).content)

				arg_404_1.text_.text = var_407_1

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_3 = 13 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 13)

				if (13 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 13)) > 0 and var_407_0 < var_407_3 then
					arg_404_1.talkMaxDuration = var_407_3

					if var_407_3 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_3 + 0
					end
				end

				arg_404_1.text_.text = var_407_1
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_4 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_4 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_4

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_4 and arg_404_1.time_ < 0 + var_407_4 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play114111100 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 114111100
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play114111101(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 1.775

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(114111100).content)

				arg_408_1.text_.text = var_411_1

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_3 = 71 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 71)

				if (71 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_1) / 71)) > 0 and var_411_0 < var_411_3 then
					arg_408_1.talkMaxDuration = var_411_3

					if var_411_3 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_3 + 0
					end
				end

				arg_408_1.text_.text = var_411_1
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_4 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_4

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play114111101 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 114111101
		arg_412_1.duration_ = 4.87

		local var_412_0 = {
			ja = 4.8,
			ko = 4.866,
			zh = 4.633,
			en = 4.366
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play114111102(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.5

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(114111101)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 21 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 21)

				if (21 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 21)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111101", "story_v_out_114111.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111101", "story_v_out_114111.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_114111", "114111101", "story_v_out_114111.awb")

						arg_412_1:RecordAudio("114111101", var_415_6)
						arg_412_1:RecordAudio("114111101", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_114111", "114111101", "story_v_out_114111.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_114111", "114111101", "story_v_out_114111.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play114111102 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 114111102
		arg_416_1.duration_ = 2.53

		local var_416_0 = {
			ja = 2.533,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play114111103(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1041ui_story = arg_416_1.actors_["1041ui_story"].transform.localPosition

				arg_416_1:ShowWeapon(arg_416_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_419_0 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 then
				arg_416_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_416_1.time_ - 0) / var_419_0)
				arg_416_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).z)
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles = arg_416_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 then
				arg_416_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_416_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_416_1.actors_["1041ui_story"].transform.position).z)
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_416_1.actors_["1041ui_story"].transform.localEulerAngles = arg_416_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_419_1 = arg_416_1.actors_["1041ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1041ui_story == nil then
				arg_416_1.var_.characterEffect1041ui_story = var_419_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_2 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_2 and not isNil(var_419_1) then
				if arg_416_1.var_.characterEffect1041ui_story and not isNil(var_419_1) then
					arg_416_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_2 and arg_416_1.time_ < 0 + var_419_2 + arg_419_0 and not isNil(var_419_1) and arg_416_1.var_.characterEffect1041ui_story then
				arg_416_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_419_4 = 0
			local var_419_5 = 0.2

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_4 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_6 = arg_416_1:GetWordFromCfg(114111102)
				local var_419_7 = arg_416_1:FormatText(var_419_6.content)

				arg_416_1.text_.text = var_419_7

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_9 = 8 <= 0 and var_419_5 or var_419_5 * (utf8.len(var_419_7) / 8)

				if (8 <= 0 and var_419_5 or var_419_5 * (utf8.len(var_419_7) / 8)) > 0 and var_419_5 < var_419_9 then
					arg_416_1.talkMaxDuration = var_419_9

					if var_419_9 + var_419_4 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_9 + var_419_4
					end
				end

				arg_416_1.text_.text = var_419_7
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111102", "story_v_out_114111.awb") ~= 0 then
					local var_419_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111102", "story_v_out_114111.awb") / 1000

					if var_419_10 + var_419_4 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_10 + var_419_4
					end

					if var_419_6.prefab_name ~= "" and arg_416_1.actors_[var_419_6.prefab_name] ~= nil then
						local var_419_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_6.prefab_name].transform, "story_v_out_114111", "114111102", "story_v_out_114111.awb")

						arg_416_1:RecordAudio("114111102", var_419_11)
						arg_416_1:RecordAudio("114111102", var_419_11)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_114111", "114111102", "story_v_out_114111.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_114111", "114111102", "story_v_out_114111.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_12 = math.max(var_419_5, arg_416_1.talkMaxDuration)

			if var_419_4 <= arg_416_1.time_ and arg_416_1.time_ < var_419_4 + var_419_12 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_4) / var_419_12

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_4 + var_419_12 and arg_416_1.time_ < var_419_4 + var_419_12 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play114111103 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 114111103
		arg_420_1.duration_ = 3.87

		local var_420_0 = {
			ja = 3.866,
			ko = 2.6,
			zh = 2.333,
			en = 2.4
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play114111104(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1041ui_story"]) and arg_420_1.var_.characterEffect1041ui_story == nil then
				arg_420_1.var_.characterEffect1041ui_story = arg_420_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1041ui_story"]) then
				if arg_420_1.var_.characterEffect1041ui_story and not isNil(arg_420_1.actors_["1041ui_story"]) then
					arg_420_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_0)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1041ui_story"]) and arg_420_1.var_.characterEffect1041ui_story then
				arg_420_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_423_1 = arg_420_1.actors_["1038ui_story"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1038ui_story = var_423_1.localPosition
			end

			local var_423_2 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 then
				var_423_1.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_420_1.time_ - 0) / var_423_2)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 then
				var_423_1.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_423_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_423_1.position).x, (manager.ui.mainCamera.transform.position - var_423_1.position).y, (manager.ui.mainCamera.transform.position - var_423_1.position).z)
				var_423_1.localEulerAngles.z = 0
				var_423_1.localEulerAngles.x = 0
				var_423_1.localEulerAngles = var_423_1.localEulerAngles
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_423_3 = arg_420_1.actors_["1038ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1038ui_story == nil then
				arg_420_1.var_.characterEffect1038ui_story = var_423_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_4 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 and not isNil(var_423_3) then
				if arg_420_1.var_.characterEffect1038ui_story and not isNil(var_423_3) then
					arg_420_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 and not isNil(var_423_3) and arg_420_1.var_.characterEffect1038ui_story then
				arg_420_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_423_6 = 0
			local var_423_7 = 0.325

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_8 = arg_420_1:GetWordFromCfg(114111103)
				local var_423_9 = arg_420_1:FormatText(var_423_8.content)

				arg_420_1.text_.text = var_423_9

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 13 <= 0 and var_423_7 or var_423_7 * (utf8.len(var_423_9) / 13)

				if (13 <= 0 and var_423_7 or var_423_7 * (utf8.len(var_423_9) / 13)) > 0 and var_423_7 < var_423_11 then
					arg_420_1.talkMaxDuration = var_423_11

					if var_423_11 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_11 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_9
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111103", "story_v_out_114111.awb") ~= 0 then
					local var_423_12 = manager.audio:GetVoiceLength("story_v_out_114111", "114111103", "story_v_out_114111.awb") / 1000

					if var_423_12 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_6
					end

					if var_423_8.prefab_name ~= "" and arg_420_1.actors_[var_423_8.prefab_name] ~= nil then
						local var_423_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_8.prefab_name].transform, "story_v_out_114111", "114111103", "story_v_out_114111.awb")

						arg_420_1:RecordAudio("114111103", var_423_13)
						arg_420_1:RecordAudio("114111103", var_423_13)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_114111", "114111103", "story_v_out_114111.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_114111", "114111103", "story_v_out_114111.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play114111104 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 114111104
		arg_424_1.duration_ = 4.2

		local var_424_0 = {
			ja = 4.2,
			ko = 2.633,
			zh = 2.133,
			en = 1.999999999999
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play114111105(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["1038ui_story"]) and arg_424_1.var_.characterEffect1038ui_story == nil then
				arg_424_1.var_.characterEffect1038ui_story = arg_424_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["1038ui_story"]) then
				if arg_424_1.var_.characterEffect1038ui_story and not isNil(arg_424_1.actors_["1038ui_story"]) then
					arg_424_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_0)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["1038ui_story"]) and arg_424_1.var_.characterEffect1038ui_story then
				arg_424_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_427_1 = arg_424_1.actors_["1041ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1041ui_story == nil then
				arg_424_1.var_.characterEffect1041ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.2

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1041ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1041ui_story then
				arg_424_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_427_4 = 0
			local var_427_5 = 0.175

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_4 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_6 = arg_424_1:GetWordFromCfg(114111104)
				local var_427_7 = arg_424_1:FormatText(var_427_6.content)

				arg_424_1.text_.text = var_427_7

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_9 = 7 <= 0 and var_427_5 or var_427_5 * (utf8.len(var_427_7) / 7)

				if (7 <= 0 and var_427_5 or var_427_5 * (utf8.len(var_427_7) / 7)) > 0 and var_427_5 < var_427_9 then
					arg_424_1.talkMaxDuration = var_427_9

					if var_427_9 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_9 + var_427_4
					end
				end

				arg_424_1.text_.text = var_427_7
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111104", "story_v_out_114111.awb") ~= 0 then
					local var_427_10 = manager.audio:GetVoiceLength("story_v_out_114111", "114111104", "story_v_out_114111.awb") / 1000

					if var_427_10 + var_427_4 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_10 + var_427_4
					end

					if var_427_6.prefab_name ~= "" and arg_424_1.actors_[var_427_6.prefab_name] ~= nil then
						local var_427_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_6.prefab_name].transform, "story_v_out_114111", "114111104", "story_v_out_114111.awb")

						arg_424_1:RecordAudio("114111104", var_427_11)
						arg_424_1:RecordAudio("114111104", var_427_11)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_114111", "114111104", "story_v_out_114111.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_114111", "114111104", "story_v_out_114111.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_12 = math.max(var_427_5, arg_424_1.talkMaxDuration)

			if var_427_4 <= arg_424_1.time_ and arg_424_1.time_ < var_427_4 + var_427_12 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_4) / var_427_12

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_4 + var_427_12 and arg_424_1.time_ < var_427_4 + var_427_12 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play114111105 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 114111105
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play114111106(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1038ui_story = arg_428_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).z)
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles = arg_428_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_428_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1038ui_story"].transform.position).z)
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1038ui_story"].transform.localEulerAngles = arg_428_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_431_1 = arg_428_1.actors_["1041ui_story"].transform

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1041ui_story = var_431_1.localPosition
			end

			local var_431_2 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 then
				var_431_1.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_428_1.time_ - 0) / var_431_2)
				var_431_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_431_1.position).x, (manager.ui.mainCamera.transform.position - var_431_1.position).y, (manager.ui.mainCamera.transform.position - var_431_1.position).z)
				var_431_1.localEulerAngles.z = 0
				var_431_1.localEulerAngles.x = 0
				var_431_1.localEulerAngles = var_431_1.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 then
				var_431_1.localPosition = Vector3.New(0, 100, 0)
				var_431_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_431_1.position).x, (manager.ui.mainCamera.transform.position - var_431_1.position).y, (manager.ui.mainCamera.transform.position - var_431_1.position).z)
				var_431_1.localEulerAngles.z = 0
				var_431_1.localEulerAngles.x = 0
				var_431_1.localEulerAngles = var_431_1.localEulerAngles
			end

			local var_431_3 = 0
			local var_431_4 = 1.025

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_3 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_5 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(114111105).content)

				arg_428_1.text_.text = var_431_5

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_7 = 41 <= 0 and var_431_4 or var_431_4 * (utf8.len(var_431_5) / 41)

				if (41 <= 0 and var_431_4 or var_431_4 * (utf8.len(var_431_5) / 41)) > 0 and var_431_4 < var_431_7 then
					arg_428_1.talkMaxDuration = var_431_7

					if var_431_7 + var_431_3 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_7 + var_431_3
					end
				end

				arg_428_1.text_.text = var_431_5
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_8 = math.max(var_431_4, arg_428_1.talkMaxDuration)

			if var_431_3 <= arg_428_1.time_ and arg_428_1.time_ < var_431_3 + var_431_8 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_3) / var_431_8

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_3 + var_431_8 and arg_428_1.time_ < var_431_3 + var_431_8 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play114111106 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 114111106
		arg_432_1.duration_ = 9

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play114111107(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_0 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 then
				local var_435_1 = Color.New(0, 0, 0)

				var_435_1.a = Mathf.Lerp(0, 1, (arg_432_1.time_ - 0) / var_435_0)
				arg_432_1.mask_.color = var_435_1
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 then
				local var_435_2 = Color.New(0, 0, 0)

				var_435_2.a = 1
				arg_432_1.mask_.color = var_435_2
			end

			local var_435_3 = 2

			if 2 < arg_432_1.time_ and arg_432_1.time_ <= var_435_3 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_4 = 2

			if var_435_3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_3 + var_435_4 then
				local var_435_5 = Color.New(0, 0, 0)

				var_435_5.a = Mathf.Lerp(1, 0, (arg_432_1.time_ - var_435_3) / var_435_4)
				arg_432_1.mask_.color = var_435_5
			end

			if arg_432_1.time_ >= var_435_3 + var_435_4 and arg_432_1.time_ < var_435_3 + var_435_4 + arg_435_0 then
				local var_435_6 = Color.New(0, 0, 0)

				arg_432_1.mask_.enabled = false
				var_435_6.a = 0
				arg_432_1.mask_.color = var_435_6
			end

			local var_435_7 = "OM0211"

			if arg_432_1.bgs_.OM0211 == nil then
				local var_435_8 = Object.Instantiate(arg_432_1.paintGo_)

				var_435_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_435_7)
				var_435_8.name = var_435_7
				var_435_8.transform.parent = arg_432_1.stage_.transform
				var_435_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.bgs_[var_435_7] = var_435_8
			end

			if 2 < arg_432_1.time_ and arg_432_1.time_ <= 2 + arg_435_0 then
				local var_435_9 = arg_432_1.bgs_.OM0211

				arg_432_1.bgs_.OM0211.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_435_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_435_10 = var_435_9:GetComponent("SpriteRenderer")

				if var_435_10 and var_435_10.sprite then
					local var_435_11 = 2 * (var_435_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_435_9.transform.localScale = Vector3.New(var_435_11 / var_435_10.sprite.bounds.size.y < var_435_11 * manager.ui.mainCameraCom_.aspect / var_435_10.sprite.bounds.size.x and var_435_11 * manager.ui.mainCameraCom_.aspect / var_435_10.sprite.bounds.size.x or var_435_11 / var_435_10.sprite.bounds.size.y, var_435_11 / var_435_10.sprite.bounds.size.y < var_435_11 * manager.ui.mainCameraCom_.aspect / var_435_10.sprite.bounds.size.x and var_435_11 * manager.ui.mainCameraCom_.aspect / var_435_10.sprite.bounds.size.x or var_435_11 / var_435_10.sprite.bounds.size.y, 0)
				end

				for iter_435_0, iter_435_1 in pairs(arg_432_1.bgs_) do
					if iter_435_0 ~= "OM0211" then
						iter_435_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_435_12 = arg_432_1.bgs_.OM0211.transform

			if 2 < arg_432_1.time_ and arg_432_1.time_ <= 2 + arg_435_0 then
				arg_432_1.var_.moveOldPosOM0211 = var_435_12.localPosition
			end

			local var_435_13 = 0.001

			if 2 <= arg_432_1.time_ and arg_432_1.time_ < 2 + var_435_13 then
				var_435_12.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPosOM0211, Vector3.New(0, 1, 9), (arg_432_1.time_ - 2) / var_435_13)
			end

			if arg_432_1.time_ >= 2 + var_435_13 and arg_432_1.time_ < 2 + var_435_13 + arg_435_0 then
				var_435_12.localPosition = Vector3.New(0, 1, 9)
			end

			local var_435_14 = arg_432_1.bgs_.OM0211.transform

			if 2.034 < arg_432_1.time_ and arg_432_1.time_ <= 2.034 + arg_435_0 then
				arg_432_1.var_.moveOldPosOM0211 = var_435_14.localPosition
			end

			local var_435_15 = 3.5

			if 2.034 <= arg_432_1.time_ and arg_432_1.time_ < 2.034 + var_435_15 then
				var_435_14.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPosOM0211, Vector3.New(0, 1, 10), (arg_432_1.time_ - 2.034) / var_435_15)
			end

			if arg_432_1.time_ >= 2.034 + var_435_15 and arg_432_1.time_ < 2.034 + var_435_15 + arg_435_0 then
				var_435_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_435_16 = 4

			if 4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_16 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			if arg_432_1.time_ >= var_435_16 + 1.534 and arg_432_1.time_ < var_435_16 + 1.534 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end

			if arg_432_1.frameCnt_ <= 1 then
				arg_432_1.dialog_:SetActive(false)
			end

			local var_435_17 = 4
			local var_435_18 = 1.55

			if 4 < arg_432_1.time_ and arg_432_1.time_ <= var_435_17 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_19 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_19:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_20 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(114111106).content)

				arg_432_1.text_.text = var_435_20

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_22 = 62 <= 0 and var_435_18 or var_435_18 * (utf8.len(var_435_20) / 62)

				if (62 <= 0 and var_435_18 or var_435_18 * (utf8.len(var_435_20) / 62)) > 0 and var_435_18 < var_435_22 then
					arg_432_1.talkMaxDuration = var_435_22
					var_435_17 = var_435_17 + 0.3

					if var_435_22 + var_435_17 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_22 + var_435_17
					end
				end

				arg_432_1.text_.text = var_435_20
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_23 = var_435_17 + 0.3
			local var_435_24 = math.max(var_435_18, arg_432_1.talkMaxDuration)

			if var_435_17 + 0.3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_23 + var_435_24 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_23) / var_435_24

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_23 + var_435_24 and arg_432_1.time_ < var_435_23 + var_435_24 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0211",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0211",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play114111107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 114111107
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play114111108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.725

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_1 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(114111107).content)

				arg_438_1.text_.text = var_441_1

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_3 = 29 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 29)

				if (29 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_1) / 29)) > 0 and var_441_0 < var_441_3 then
					arg_438_1.talkMaxDuration = var_441_3

					if var_441_3 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_3 + 0
					end
				end

				arg_438_1.text_.text = var_441_1
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_4 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_4 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_4

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_4 and arg_438_1.time_ < 0 + var_441_4 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play114111108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 114111108
		arg_442_1.duration_ = 5.57

		local var_442_0 = {
			ja = 5.066,
			ko = 5.566,
			zh = 4.166,
			en = 4.733
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play114111109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.55

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_1 = arg_442_1:GetWordFromCfg(114111108)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 22 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 22)

				if (22 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 22)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111108", "story_v_out_114111.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111108", "story_v_out_114111.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_out_114111", "114111108", "story_v_out_114111.awb")

						arg_442_1:RecordAudio("114111108", var_445_6)
						arg_442_1:RecordAudio("114111108", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_114111", "114111108", "story_v_out_114111.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_114111", "114111108", "story_v_out_114111.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play114111109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 114111109
		arg_446_1.duration_ = 9.03

		local var_446_0 = {
			ja = 4.866,
			ko = 8.9,
			zh = 7.5,
			en = 9.033
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play114111110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.9

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1038_split_5")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_1 = arg_446_1:GetWordFromCfg(114111109)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 36 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 36)

				if (36 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 36)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111109", "story_v_out_114111.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111109", "story_v_out_114111.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_out_114111", "114111109", "story_v_out_114111.awb")

						arg_446_1:RecordAudio("114111109", var_449_6)
						arg_446_1:RecordAudio("114111109", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_114111", "114111109", "story_v_out_114111.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_114111", "114111109", "story_v_out_114111.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play114111110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 114111110
		arg_450_1.duration_ = 7.4

		local var_450_0 = {
			ja = 7.4,
			ko = 5.2,
			zh = 5.966,
			en = 4.966
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play114111111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.525

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(114111110)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 21 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 21)

				if (21 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 21)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114111", "114111110", "story_v_out_114111.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_114111", "114111110", "story_v_out_114111.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_114111", "114111110", "story_v_out_114111.awb")

						arg_450_1:RecordAudio("114111110", var_453_6)
						arg_450_1:RecordAudio("114111110", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_114111", "114111110", "story_v_out_114111.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_114111", "114111110", "story_v_out_114111.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play114111111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 114111111
		arg_454_1.duration_ = 5

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play114111112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 1.525

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, false)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(114111111).content)

				arg_454_1.text_.text = var_457_1

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_3 = 61 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 61)

				if (61 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_1) / 61)) > 0 and var_457_0 < var_457_3 then
					arg_454_1.talkMaxDuration = var_457_3

					if var_457_3 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_3 + 0
					end
				end

				arg_454_1.text_.text = var_457_1
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)
				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_4 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_4 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_4

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_4 and arg_454_1.time_ < 0 + var_457_4 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play114111112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 114111112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play114111113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = 1.425

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_1 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(114111112).content)

				arg_458_1.text_.text = var_461_1

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_3 = 57 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 57)

				if (57 <= 0 and var_461_0 or var_461_0 * (utf8.len(var_461_1) / 57)) > 0 and var_461_0 < var_461_3 then
					arg_458_1.talkMaxDuration = var_461_3

					if var_461_3 + 0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_3 + 0
					end
				end

				arg_458_1.text_.text = var_461_1
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_4 = math.max(var_461_0, arg_458_1.talkMaxDuration)

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_4 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - 0) / var_461_4

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= 0 + var_461_4 and arg_458_1.time_ < 0 + var_461_4 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play114111113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 114111113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
			arg_462_1.auto_ = false
		end

		function arg_462_1.playNext_(arg_464_0)
			arg_462_1.onStoryFinished_()
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 1.175

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(114111113).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 47 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 47)

				if (47 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 47)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/OM0206",
		"TextureConfig/Background/F05_1",
		"TextureConfig/Background/OM0211"
	},
	voices = {
		"story_v_out_114111.awb"
	}
}
