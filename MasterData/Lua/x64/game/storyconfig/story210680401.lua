return {
	Play1106804001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106804001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106804002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST22 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_4_0.name = "ST22"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22

				arg_1_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22" then
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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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
			local var_4_15 = 0.7

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1106804001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)

				if (25 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 25)) > 0 and var_4_15 < var_4_19 then
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
	Play1106804002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1106804002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1106804003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1106804002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)

				if (40 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 40)) > 0 and var_12_0 < var_12_3 then
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
	Play1106804003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1106804003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1106804004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1106804003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 13)

				if (13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 13)) > 0 and var_16_0 < var_16_3 then
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
	Play1106804004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1106804004
		arg_17_1.duration_ = 12.17

		local var_17_0 = {
			ja = 7.866,
			ko = 12.166,
			zh = 12.166
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
				arg_17_0:Play1106804005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1068ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1068ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1068ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1068ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1068ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1068ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1068ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_20_5 = arg_17_1.actors_["1068ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1068ui_story == nil then
				arg_17_1.var_.characterEffect1068ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1068ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1068ui_story then
				arg_17_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 1.5

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1106804004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 60 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 60)

				if (60 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 60)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804004", "story_v_side_new_1106804.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804004", "story_v_side_new_1106804.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1106804", "1106804004", "story_v_side_new_1106804.awb")

						arg_17_1:RecordAudio("1106804004", var_20_15)
						arg_17_1:RecordAudio("1106804004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804004", "story_v_side_new_1106804.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804004", "story_v_side_new_1106804.awb")
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
				actorName = "1068ui_story",
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
	Play1106804005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1106804005
		arg_21_1.duration_ = 13.1

		local var_21_0 = {
			ja = 13.1,
			ko = 7.6,
			zh = 7.6
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
				arg_21_0:Play1106804006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.025

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(1106804005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 41)

				if (41 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 41)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804005", "story_v_side_new_1106804.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804005", "story_v_side_new_1106804.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_side_new_1106804", "1106804005", "story_v_side_new_1106804.awb")

						arg_21_1:RecordAudio("1106804005", var_24_6)
						arg_21_1:RecordAudio("1106804005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804005", "story_v_side_new_1106804.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804005", "story_v_side_new_1106804.awb")
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
	Play1106804006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1106804006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1106804007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) and arg_25_1.var_.characterEffect1068ui_story == nil then
				arg_25_1.var_.characterEffect1068ui_story = arg_25_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) then
				if arg_25_1.var_.characterEffect1068ui_story and not isNil(arg_25_1.actors_["1068ui_story"]) then
					arg_25_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) and arg_25_1.var_.characterEffect1068ui_story then
				arg_25_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1106804006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 57 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 57)

				if (57 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 57)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1106804007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1106804007
		arg_29_1.duration_ = 7.93

		local var_29_0 = {
			ja = 7.933,
			ko = 6.1,
			zh = 6.1
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
				arg_29_0:Play1106804008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_32_0 = arg_29_1.actors_["1068ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story == nil then
				arg_29_1.var_.characterEffect1068ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1068ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story then
				arg_29_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_32_3 = 0
			local var_32_4 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:GetWordFromCfg(1106804007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 31 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 31)

				if (31 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 31)) > 0 and var_32_4 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804007", "story_v_side_new_1106804.awb") ~= 0 then
					local var_32_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804007", "story_v_side_new_1106804.awb") / 1000

					if var_32_9 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_3
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_side_new_1106804", "1106804007", "story_v_side_new_1106804.awb")

						arg_29_1:RecordAudio("1106804007", var_32_10)
						arg_29_1:RecordAudio("1106804007", var_32_10)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804007", "story_v_side_new_1106804.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804007", "story_v_side_new_1106804.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_11 and arg_29_1.time_ < var_32_3 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1106804008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1106804008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1106804009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1068ui_story"]) and arg_33_1.var_.characterEffect1068ui_story == nil then
				arg_33_1.var_.characterEffect1068ui_story = arg_33_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1068ui_story"]) then
				if arg_33_1.var_.characterEffect1068ui_story and not isNil(arg_33_1.actors_["1068ui_story"]) then
					arg_33_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1068ui_story"]) and arg_33_1.var_.characterEffect1068ui_story then
				arg_33_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1106804008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 14 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 14)

				if (14 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 14)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1106804009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1106804009
		arg_37_1.duration_ = 11.87

		local var_37_0 = {
			ja = 11.866,
			ko = 11.033,
			zh = 11.033
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
				arg_37_0:Play1106804010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_40_0 = arg_37_1.actors_["1068ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1068ui_story == nil then
				arg_37_1.var_.characterEffect1068ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_1 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(var_40_0) then
				if arg_37_1.var_.characterEffect1068ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1068ui_story then
				arg_37_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_40_3 = 0
			local var_40_4 = 1.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:GetWordFromCfg(1106804009)
				local var_40_6 = arg_37_1:FormatText(var_40_5.content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 57 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 57)

				if (57 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_6) / 57)) > 0 and var_40_4 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804009", "story_v_side_new_1106804.awb") ~= 0 then
					local var_40_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804009", "story_v_side_new_1106804.awb") / 1000

					if var_40_9 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_3
					end

					if var_40_5.prefab_name ~= "" and arg_37_1.actors_[var_40_5.prefab_name] ~= nil then
						local var_40_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_5.prefab_name].transform, "story_v_side_new_1106804", "1106804009", "story_v_side_new_1106804.awb")

						arg_37_1:RecordAudio("1106804009", var_40_10)
						arg_37_1:RecordAudio("1106804009", var_40_10)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804009", "story_v_side_new_1106804.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804009", "story_v_side_new_1106804.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_11 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_11 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_11

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_11 and arg_37_1.time_ < var_40_3 + var_40_11 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1106804010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1106804010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1106804011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1068ui_story"]) and arg_41_1.var_.characterEffect1068ui_story == nil then
				arg_41_1.var_.characterEffect1068ui_story = arg_41_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1068ui_story"]) then
				if arg_41_1.var_.characterEffect1068ui_story and not isNil(arg_41_1.actors_["1068ui_story"]) then
					arg_41_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1068ui_story"]) and arg_41_1.var_.characterEffect1068ui_story then
				arg_41_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 1.05

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1106804010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 42 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 42)

				if (42 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 42)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1106804011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1106804011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1106804012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1106804011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 20 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 20)

				if (20 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 20)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1106804012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1106804012
		arg_49_1.duration_ = 8.2

		local var_49_0 = {
			ja = 8.2,
			ko = 5.233,
			zh = 5.233
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
				arg_49_0:Play1106804013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_52_0 = arg_49_1.actors_["1068ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1068ui_story == nil then
				arg_49_1.var_.characterEffect1068ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect1068ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1068ui_story then
				arg_49_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_52_3 = 0
			local var_52_4 = 0.85

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(1106804012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 22 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 22)

				if (22 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 22)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804012", "story_v_side_new_1106804.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804012", "story_v_side_new_1106804.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_side_new_1106804", "1106804012", "story_v_side_new_1106804.awb")

						arg_49_1:RecordAudio("1106804012", var_52_10)
						arg_49_1:RecordAudio("1106804012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804012", "story_v_side_new_1106804.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804012", "story_v_side_new_1106804.awb")
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
	Play1106804013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1106804013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1106804014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1068ui_story"]) and arg_53_1.var_.characterEffect1068ui_story == nil then
				arg_53_1.var_.characterEffect1068ui_story = arg_53_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1068ui_story"]) then
				if arg_53_1.var_.characterEffect1068ui_story and not isNil(arg_53_1.actors_["1068ui_story"]) then
					arg_53_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1068ui_story"]) and arg_53_1.var_.characterEffect1068ui_story then
				arg_53_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1106804013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 14 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 14)

				if (14 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 14)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1106804014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1106804014
		arg_57_1.duration_ = 12.47

		local var_57_0 = {
			ja = 12.466,
			ko = 6.7,
			zh = 6.7
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
				arg_57_0:Play1106804015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068actionlink/1068action462")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_0 = arg_57_1.actors_["1068ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1068ui_story == nil then
				arg_57_1.var_.characterEffect1068ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_1 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 and not isNil(var_60_0) then
				if arg_57_1.var_.characterEffect1068ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1068ui_story then
				arg_57_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_60_3 = 0
			local var_60_4 = 0.85

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:GetWordFromCfg(1106804014)
				local var_60_6 = arg_57_1:FormatText(var_60_5.content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 34 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_6) / 34)

				if (34 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_6) / 34)) > 0 and var_60_4 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804014", "story_v_side_new_1106804.awb") ~= 0 then
					local var_60_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804014", "story_v_side_new_1106804.awb") / 1000

					if var_60_9 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_3
					end

					if var_60_5.prefab_name ~= "" and arg_57_1.actors_[var_60_5.prefab_name] ~= nil then
						local var_60_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_5.prefab_name].transform, "story_v_side_new_1106804", "1106804014", "story_v_side_new_1106804.awb")

						arg_57_1:RecordAudio("1106804014", var_60_10)
						arg_57_1:RecordAudio("1106804014", var_60_10)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804014", "story_v_side_new_1106804.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804014", "story_v_side_new_1106804.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_11 and arg_57_1.time_ < var_60_3 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1106804015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1106804015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1106804016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1068ui_story"]) and arg_61_1.var_.characterEffect1068ui_story == nil then
				arg_61_1.var_.characterEffect1068ui_story = arg_61_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1068ui_story"]) then
				if arg_61_1.var_.characterEffect1068ui_story and not isNil(arg_61_1.actors_["1068ui_story"]) then
					arg_61_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1068ui_story"]) and arg_61_1.var_.characterEffect1068ui_story then
				arg_61_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_64_1 = 0
			local var_64_2 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1106804015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 6 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 6)

				if (6 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 6)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1106804016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1106804016
		arg_65_1.duration_ = 6.57

		local var_65_0 = {
			ja = 6.566,
			ko = 4.3,
			zh = 4.3
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
				arg_65_0:Play1106804017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_68_0 = arg_65_1.actors_["1068ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1068ui_story == nil then
				arg_65_1.var_.characterEffect1068ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_1 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 and not isNil(var_68_0) then
				if arg_65_1.var_.characterEffect1068ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1068ui_story then
				arg_65_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_68_3 = 0
			local var_68_4 = 0.475

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_5 = arg_65_1:GetWordFromCfg(1106804016)
				local var_68_6 = arg_65_1:FormatText(var_68_5.content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 19 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_6) / 19)

				if (19 <= 0 and var_68_4 or var_68_4 * (utf8.len(var_68_6) / 19)) > 0 and var_68_4 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_3
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804016", "story_v_side_new_1106804.awb") ~= 0 then
					local var_68_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804016", "story_v_side_new_1106804.awb") / 1000

					if var_68_9 + var_68_3 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_3
					end

					if var_68_5.prefab_name ~= "" and arg_65_1.actors_[var_68_5.prefab_name] ~= nil then
						local var_68_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_5.prefab_name].transform, "story_v_side_new_1106804", "1106804016", "story_v_side_new_1106804.awb")

						arg_65_1:RecordAudio("1106804016", var_68_10)
						arg_65_1:RecordAudio("1106804016", var_68_10)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804016", "story_v_side_new_1106804.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804016", "story_v_side_new_1106804.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_4, arg_65_1.talkMaxDuration)

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_3) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_3 + var_68_11 and arg_65_1.time_ < var_68_3 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1106804017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1106804017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1106804018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1068ui_story"]) and arg_69_1.var_.characterEffect1068ui_story == nil then
				arg_69_1.var_.characterEffect1068ui_story = arg_69_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1068ui_story"]) then
				if arg_69_1.var_.characterEffect1068ui_story and not isNil(arg_69_1.actors_["1068ui_story"]) then
					arg_69_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1068ui_story"]) and arg_69_1.var_.characterEffect1068ui_story then
				arg_69_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.975

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(1106804017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 39 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 39)

				if (39 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 39)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1106804018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1106804018
		arg_73_1.duration_ = 10.2

		local var_73_0 = {
			ja = 6.933,
			ko = 10.2,
			zh = 10.2
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
				arg_73_0:Play1106804019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_76_0 = arg_73_1.actors_["1068ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1068ui_story == nil then
				arg_73_1.var_.characterEffect1068ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_1 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(var_76_0) then
				if arg_73_1.var_.characterEffect1068ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1068ui_story then
				arg_73_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_76_3 = 0
			local var_76_4 = 1.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:GetWordFromCfg(1106804018)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 52 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 52)

				if (52 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 52)) > 0 and var_76_4 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804018", "story_v_side_new_1106804.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804018", "story_v_side_new_1106804.awb") / 1000

					if var_76_9 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_3
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_side_new_1106804", "1106804018", "story_v_side_new_1106804.awb")

						arg_73_1:RecordAudio("1106804018", var_76_10)
						arg_73_1:RecordAudio("1106804018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804018", "story_v_side_new_1106804.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804018", "story_v_side_new_1106804.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_11 and arg_73_1.time_ < var_76_3 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1106804019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1106804019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1106804020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1068ui_story"]) and arg_77_1.var_.characterEffect1068ui_story == nil then
				arg_77_1.var_.characterEffect1068ui_story = arg_77_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1068ui_story"]) then
				if arg_77_1.var_.characterEffect1068ui_story and not isNil(arg_77_1.actors_["1068ui_story"]) then
					arg_77_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1068ui_story"]) and arg_77_1.var_.characterEffect1068ui_story then
				arg_77_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0
			local var_80_2 = 0.275

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(1106804019).content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 11 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 11)

				if (11 <= 0 and var_80_2 or var_80_2 * (utf8.len(var_80_3) / 11)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_1 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_1
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_6 = math.max(var_80_2, arg_77_1.talkMaxDuration)

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_6 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_1) / var_80_6

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_1 + var_80_6 and arg_77_1.time_ < var_80_1 + var_80_6 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1106804020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1106804020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1106804021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_84_0 = arg_81_1.actors_["1068ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1068ui_story == nil then
				arg_81_1.var_.characterEffect1068ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_1 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 and not isNil(var_84_0) then
				if arg_81_1.var_.characterEffect1068ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1068ui_story then
				arg_81_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_84_3 = 0
			local var_84_4 = 0.7

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1106804020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 28 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 28)

				if (28 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 28)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1106804021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1106804021
		arg_85_1.duration_ = 6.4

		local var_85_0 = {
			ja = 4.6,
			ko = 6.4,
			zh = 6.4
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
				arg_85_0:Play1106804022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_0 = 0
			local var_88_1 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(1106804021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 32 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 32)

				if (32 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 32)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804021", "story_v_side_new_1106804.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804021", "story_v_side_new_1106804.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_side_new_1106804", "1106804021", "story_v_side_new_1106804.awb")

						arg_85_1:RecordAudio("1106804021", var_88_7)
						arg_85_1:RecordAudio("1106804021", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804021", "story_v_side_new_1106804.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804021", "story_v_side_new_1106804.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1106804022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1106804022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1106804023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1068ui_story"]) and arg_89_1.var_.characterEffect1068ui_story == nil then
				arg_89_1.var_.characterEffect1068ui_story = arg_89_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1068ui_story"]) then
				if arg_89_1.var_.characterEffect1068ui_story and not isNil(arg_89_1.actors_["1068ui_story"]) then
					arg_89_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1068ui_story"]) and arg_89_1.var_.characterEffect1068ui_story then
				arg_89_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.25

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1106804022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 10 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 10)

				if (10 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 10)) > 0 and var_92_2 < var_92_5 then
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
	Play1106804023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1106804023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1106804024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1106804023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 43 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 43)

				if (43 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 43)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1106804024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1106804024
		arg_97_1.duration_ = 9.6

		local var_97_0 = {
			ja = 9.166,
			ko = 9.6,
			zh = 9.6
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
				arg_97_0:Play1106804025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_100_0 = arg_97_1.actors_["1068ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1068ui_story == nil then
				arg_97_1.var_.characterEffect1068ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_1 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 and not isNil(var_100_0) then
				if arg_97_1.var_.characterEffect1068ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1068ui_story then
				arg_97_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_100_3 = 0
			local var_100_4 = 1.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:GetWordFromCfg(1106804024)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 46 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_6) / 46)

				if (46 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_6) / 46)) > 0 and var_100_4 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804024", "story_v_side_new_1106804.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804024", "story_v_side_new_1106804.awb") / 1000

					if var_100_9 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_3
					end

					if var_100_5.prefab_name ~= "" and arg_97_1.actors_[var_100_5.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_5.prefab_name].transform, "story_v_side_new_1106804", "1106804024", "story_v_side_new_1106804.awb")

						arg_97_1:RecordAudio("1106804024", var_100_10)
						arg_97_1:RecordAudio("1106804024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804024", "story_v_side_new_1106804.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804024", "story_v_side_new_1106804.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_11 and arg_97_1.time_ < var_100_3 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1106804025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1106804025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1106804026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1068ui_story"]) and arg_101_1.var_.characterEffect1068ui_story == nil then
				arg_101_1.var_.characterEffect1068ui_story = arg_101_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1068ui_story"]) then
				if arg_101_1.var_.characterEffect1068ui_story and not isNil(arg_101_1.actors_["1068ui_story"]) then
					arg_101_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1068ui_story"]) and arg_101_1.var_.characterEffect1068ui_story then
				arg_101_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 1.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1106804025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 49 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 49)

				if (49 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 49)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1106804026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1106804026
		arg_105_1.duration_ = 7.6

		local var_105_0 = {
			ja = 7.532999999999,
			ko = 7.599999999999,
			zh = 7.599999999999
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
				arg_105_0:Play1106804027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.ST17 == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_108_0.name = "ST17"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.ST17 = var_108_0
			end

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.ST17

				arg_105_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST17" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_5 = 2

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_5 then
				local var_108_6 = Color.New(0, 0, 0)

				var_108_6.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_4) / var_108_5)
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.time_ >= var_108_4 + var_108_5 and arg_105_1.time_ < var_108_4 + var_108_5 + arg_108_0 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = 1
				arg_105_1.mask_.color = var_108_7
			end

			local var_108_8 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 then
				local var_108_10 = Color.New(0, 0, 0)

				var_108_10.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_8) / var_108_9)
				arg_105_1.mask_.color = var_108_10
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 then
				local var_108_11 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_11.a = 0
				arg_105_1.mask_.color = var_108_11
			end

			local var_108_12 = arg_105_1.actors_["1068ui_story"].transform

			if 1.966 < arg_105_1.time_ and arg_105_1.time_ <= 1.966 + arg_108_0 then
				arg_105_1.var_.moveOldPos1068ui_story = var_108_12.localPosition
			end

			local var_108_13 = 0.001

			if 1.966 <= arg_105_1.time_ and arg_105_1.time_ < 1.966 + var_108_13 then
				var_108_12.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 1.966) / var_108_13)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			if arg_105_1.time_ >= 1.966 + var_108_13 and arg_105_1.time_ < 1.966 + var_108_13 + arg_108_0 then
				var_108_12.localPosition = Vector3.New(0, 100, 0)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_14 = 3.999999999999
			local var_108_15 = 0.525

			if 3.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_16 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_16:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[415].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_17 = arg_105_1:GetWordFromCfg(1106804026)
				local var_108_18 = arg_105_1:FormatText(var_108_17.content)

				arg_105_1.text_.text = var_108_18

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 21 <= 0 and var_108_15 or var_108_15 * (utf8.len(var_108_18) / 21)

				if (21 <= 0 and var_108_15 or var_108_15 * (utf8.len(var_108_18) / 21)) > 0 and var_108_15 < var_108_20 then
					arg_105_1.talkMaxDuration = var_108_20
					var_108_14 = var_108_14 + 0.3

					if var_108_20 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_14
					end
				end

				arg_105_1.text_.text = var_108_18
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804026", "story_v_side_new_1106804.awb") ~= 0 then
					local var_108_21 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804026", "story_v_side_new_1106804.awb") / 1000

					if var_108_21 + var_108_14 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_14
					end

					if var_108_17.prefab_name ~= "" and arg_105_1.actors_[var_108_17.prefab_name] ~= nil then
						local var_108_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_17.prefab_name].transform, "story_v_side_new_1106804", "1106804026", "story_v_side_new_1106804.awb")

						arg_105_1:RecordAudio("1106804026", var_108_22)
						arg_105_1:RecordAudio("1106804026", var_108_22)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804026", "story_v_side_new_1106804.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804026", "story_v_side_new_1106804.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_23 = var_108_14 + 0.3
			local var_108_24 = math.max(var_108_15, arg_105_1.talkMaxDuration)

			if var_108_14 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_24 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_24

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_24 and arg_105_1.time_ < var_108_23 + var_108_24 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play1106804027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1106804027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1106804028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.6

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1106804027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 24)

				if (24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 24)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1106804028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1106804028
		arg_115_1.duration_ = 5.47

		local var_115_0 = {
			ja = 4.5,
			ko = 5.466,
			zh = 5.466
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
				arg_115_0:Play1106804029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0.5 < arg_115_1.time_ and arg_115_1.time_ <= 0.5 + arg_118_0 then
				arg_115_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_118_1 = 0
			local var_118_2 = 0.6

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[415].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_3 = arg_115_1:GetWordFromCfg(1106804028)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_6 = 24 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_4) / 24)

				if (24 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_4) / 24)) > 0 and var_118_2 < var_118_6 then
					arg_115_1.talkMaxDuration = var_118_6

					if var_118_6 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804028", "story_v_side_new_1106804.awb") ~= 0 then
					local var_118_7 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804028", "story_v_side_new_1106804.awb") / 1000

					if var_118_7 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_1
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_side_new_1106804", "1106804028", "story_v_side_new_1106804.awb")

						arg_115_1:RecordAudio("1106804028", var_118_8)
						arg_115_1:RecordAudio("1106804028", var_118_8)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804028", "story_v_side_new_1106804.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804028", "story_v_side_new_1106804.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_9 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_9 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_9

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_9 and arg_115_1.time_ < var_118_1 + var_118_9 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1106804029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1106804029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1106804030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:AudioAction("stop", "music", "se_story_side_1068", "se_story_1068_footstep", "")

				local var_122_2 = manager.audio:GetAudioName("se_story_side_1068", "se_story_1068_footstep")

				if "" ~= "" then
					if arg_119_1.bgmTxt_.text ~= var_122_2 and arg_119_1.bgmTxt_.text ~= "" then
						if arg_119_1.bgmTxt2_.text ~= "" then
							arg_119_1.bgmTxt_.text = arg_119_1.bgmTxt2_.text
						end

						arg_119_1.bgmTxt2_.text = var_122_2

						arg_119_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_119_1.bgmTxt_.text = var_122_2
						arg_119_1.bgmTxt2_.text = var_122_2
					end

					if arg_119_1.bgmTimer then
						arg_119_1.bgmTimer:Stop()

						arg_119_1.bgmTimer = nil
					end

					if arg_119_1.settingData.show_music_name == 1 then
						arg_119_1.musicController:SetSelectedState("show")
						arg_119_1.musicAnimator_:Play("open", 0, 0)

						if arg_119_1.settingData.music_time ~= 0 then
							arg_119_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_119_1.settingData.music_time), function()
								if arg_119_1 == nil or isNil(arg_119_1.bgmTxt_) then
									return
								end

								arg_119_1.musicController:SetSelectedState("hide")
								arg_119_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_122_3 = 0
			local var_122_4 = 0.65

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_5 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1106804029).content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 26 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_5) / 26)

				if (26 <= 0 and var_122_4 or var_122_4 * (utf8.len(var_122_5) / 26)) > 0 and var_122_4 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_3 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_3
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_4, arg_119_1.talkMaxDuration)

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_3) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_3 + var_122_8 and arg_119_1.time_ < var_122_3 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1106804030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1106804030
		arg_124_1.duration_ = 10.8

		local var_124_0 = {
			ja = 10.8,
			ko = 8.466,
			zh = 8.466
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1106804031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.1

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[415].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(1106804030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 44 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 44)

				if (44 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 44)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804030", "story_v_side_new_1106804.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804030", "story_v_side_new_1106804.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_side_new_1106804", "1106804030", "story_v_side_new_1106804.awb")

						arg_124_1:RecordAudio("1106804030", var_127_6)
						arg_124_1:RecordAudio("1106804030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804030", "story_v_side_new_1106804.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804030", "story_v_side_new_1106804.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play1106804031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1106804031
		arg_128_1.duration_ = 8.27

		local var_128_0 = {
			ja = 6.733,
			ko = 8.266,
			zh = 8.266
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1106804032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1068ui_story = arg_128_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).z)
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles = arg_128_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_128_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1068ui_story"].transform.position).z)
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1068ui_story"].transform.localEulerAngles = arg_128_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_131_1 = arg_128_1.actors_["1068ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1068ui_story == nil then
				arg_128_1.var_.characterEffect1068ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1068ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1068ui_story then
				arg_128_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.925

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(1106804031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 37 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 37)

				if (37 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 37)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804031", "story_v_side_new_1106804.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804031", "story_v_side_new_1106804.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_side_new_1106804", "1106804031", "story_v_side_new_1106804.awb")

						arg_128_1:RecordAudio("1106804031", var_131_11)
						arg_128_1:RecordAudio("1106804031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804031", "story_v_side_new_1106804.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804031", "story_v_side_new_1106804.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play1106804032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1106804032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1106804033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1068ui_story"]) and arg_132_1.var_.characterEffect1068ui_story == nil then
				arg_132_1.var_.characterEffect1068ui_story = arg_132_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1068ui_story"]) then
				if arg_132_1.var_.characterEffect1068ui_story and not isNil(arg_132_1.actors_["1068ui_story"]) then
					arg_132_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1068ui_story"]) and arg_132_1.var_.characterEffect1068ui_story then
				arg_132_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.525

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(1106804032).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 21 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 21)

				if (21 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 21)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1106804033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1106804033
		arg_136_1.duration_ = 10.6

		local var_136_0 = {
			ja = 10.4,
			ko = 10.6,
			zh = 10.6
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
				arg_136_0:Play1106804034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 1.275

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[415].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(1106804033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 51 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 51)

				if (51 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 51)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804033", "story_v_side_new_1106804.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804033", "story_v_side_new_1106804.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_side_new_1106804", "1106804033", "story_v_side_new_1106804.awb")

						arg_136_1:RecordAudio("1106804033", var_139_6)
						arg_136_1:RecordAudio("1106804033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804033", "story_v_side_new_1106804.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804033", "story_v_side_new_1106804.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1106804034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1106804034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1106804035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.05

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(1106804034).content)

				arg_140_1.text_.text = var_143_1

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_3 = 42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 42)

				if (42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_1) / 42)) > 0 and var_143_0 < var_143_3 then
					arg_140_1.talkMaxDuration = var_143_3

					if var_143_3 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_3 + 0
					end
				end

				arg_140_1.text_.text = var_143_1
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_4 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_4

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1106804035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1106804035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1106804036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.875

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(1106804035).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 35 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 35)

				if (35 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 35)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1106804036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1106804036
		arg_148_1.duration_ = 6.77

		local var_148_0 = {
			ja = 6.766,
			ko = 5.566,
			zh = 5.566
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
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1106804037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_151_0 = arg_148_1.actors_["1068ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1068ui_story == nil then
				arg_148_1.var_.characterEffect1068ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_1 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_1 and not isNil(var_151_0) then
				if arg_148_1.var_.characterEffect1068ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_1 and arg_148_1.time_ < 0 + var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1068ui_story then
				arg_148_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_151_3 = 0
			local var_151_4 = 0.525

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_3 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_5 = arg_148_1:GetWordFromCfg(1106804036)
				local var_151_6 = arg_148_1:FormatText(var_151_5.content)

				arg_148_1.text_.text = var_151_6

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_8 = 21 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_6) / 21)

				if (21 <= 0 and var_151_4 or var_151_4 * (utf8.len(var_151_6) / 21)) > 0 and var_151_4 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_3
					end
				end

				arg_148_1.text_.text = var_151_6
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804036", "story_v_side_new_1106804.awb") ~= 0 then
					local var_151_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804036", "story_v_side_new_1106804.awb") / 1000

					if var_151_9 + var_151_3 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_3
					end

					if var_151_5.prefab_name ~= "" and arg_148_1.actors_[var_151_5.prefab_name] ~= nil then
						local var_151_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_5.prefab_name].transform, "story_v_side_new_1106804", "1106804036", "story_v_side_new_1106804.awb")

						arg_148_1:RecordAudio("1106804036", var_151_10)
						arg_148_1:RecordAudio("1106804036", var_151_10)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804036", "story_v_side_new_1106804.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804036", "story_v_side_new_1106804.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_4, arg_148_1.talkMaxDuration)

			if var_151_3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_3 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_3) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_3 + var_151_11 and arg_148_1.time_ < var_151_3 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play1106804037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1106804037
		arg_152_1.duration_ = 6.7

		local var_152_0 = {
			ja = 6.7,
			ko = 2.333,
			zh = 2.333
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1106804038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_155_0 = 0
			local var_155_1 = 0.325

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(1106804037)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 13 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 13)

				if (13 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 13)) > 0 and var_155_1 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804037", "story_v_side_new_1106804.awb") ~= 0 then
					local var_155_6 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804037", "story_v_side_new_1106804.awb") / 1000

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end

					if var_155_2.prefab_name ~= "" and arg_152_1.actors_[var_155_2.prefab_name] ~= nil then
						local var_155_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_2.prefab_name].transform, "story_v_side_new_1106804", "1106804037", "story_v_side_new_1106804.awb")

						arg_152_1:RecordAudio("1106804037", var_155_7)
						arg_152_1:RecordAudio("1106804037", var_155_7)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804037", "story_v_side_new_1106804.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804037", "story_v_side_new_1106804.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1106804038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1106804038
		arg_156_1.duration_ = 5.13

		local var_156_0 = {
			ja = 5.133,
			ko = 2.7,
			zh = 2.7
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1106804039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			local var_159_0 = 0
			local var_159_1 = 0.275

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(1106804038)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 11 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 11)

				if (11 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 11)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804038", "story_v_side_new_1106804.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804038", "story_v_side_new_1106804.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_side_new_1106804", "1106804038", "story_v_side_new_1106804.awb")

						arg_156_1:RecordAudio("1106804038", var_159_7)
						arg_156_1:RecordAudio("1106804038", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804038", "story_v_side_new_1106804.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804038", "story_v_side_new_1106804.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1106804039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1106804039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1106804040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1068ui_story"]) and arg_160_1.var_.characterEffect1068ui_story == nil then
				arg_160_1.var_.characterEffect1068ui_story = arg_160_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1068ui_story"]) then
				if arg_160_1.var_.characterEffect1068ui_story and not isNil(arg_160_1.actors_["1068ui_story"]) then
					arg_160_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1068ui_story"]) and arg_160_1.var_.characterEffect1068ui_story then
				arg_160_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.625

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(1106804039).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 25 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 25)

				if (25 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 25)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1106804040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1106804040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1106804041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.125

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(1106804040).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 5 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 5)

				if (5 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 5)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1106804041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1106804041
		arg_168_1.duration_ = 10.87

		local var_168_0 = {
			ja = 10.866,
			ko = 8.466,
			zh = 8.466
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1106804042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_171_0 = arg_168_1.actors_["1068ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1068ui_story == nil then
				arg_168_1.var_.characterEffect1068ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_1 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 and not isNil(var_171_0) then
				if arg_168_1.var_.characterEffect1068ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect1068ui_story then
				arg_168_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_171_3 = 0
			local var_171_4 = 0.95

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_3 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_5 = arg_168_1:GetWordFromCfg(1106804041)
				local var_171_6 = arg_168_1:FormatText(var_171_5.content)

				arg_168_1.text_.text = var_171_6

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_8 = 38 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 38)

				if (38 <= 0 and var_171_4 or var_171_4 * (utf8.len(var_171_6) / 38)) > 0 and var_171_4 < var_171_8 then
					arg_168_1.talkMaxDuration = var_171_8

					if var_171_8 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_3
					end
				end

				arg_168_1.text_.text = var_171_6
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804041", "story_v_side_new_1106804.awb") ~= 0 then
					local var_171_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804041", "story_v_side_new_1106804.awb") / 1000

					if var_171_9 + var_171_3 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_3
					end

					if var_171_5.prefab_name ~= "" and arg_168_1.actors_[var_171_5.prefab_name] ~= nil then
						local var_171_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_5.prefab_name].transform, "story_v_side_new_1106804", "1106804041", "story_v_side_new_1106804.awb")

						arg_168_1:RecordAudio("1106804041", var_171_10)
						arg_168_1:RecordAudio("1106804041", var_171_10)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804041", "story_v_side_new_1106804.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804041", "story_v_side_new_1106804.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_4, arg_168_1.talkMaxDuration)

			if var_171_3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_3 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_3) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_3 + var_171_11 and arg_168_1.time_ < var_171_3 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1106804042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1106804042
		arg_172_1.duration_ = 6.97

		local var_172_0 = {
			ja = 6.966,
			ko = 5.966,
			zh = 5.966
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1106804043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.825

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(1106804042)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 33 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 33)

				if (33 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 33)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804042", "story_v_side_new_1106804.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804042", "story_v_side_new_1106804.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_side_new_1106804", "1106804042", "story_v_side_new_1106804.awb")

						arg_172_1:RecordAudio("1106804042", var_175_6)
						arg_172_1:RecordAudio("1106804042", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804042", "story_v_side_new_1106804.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804042", "story_v_side_new_1106804.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1106804043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1106804043
		arg_176_1.duration_ = 8.27

		local var_176_0 = {
			ja = 8.266,
			ko = 4.6,
			zh = 4.6
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1106804044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068actionlink/1068action442")
			end

			local var_179_0 = 0
			local var_179_1 = 0.7

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_2 = arg_176_1:GetWordFromCfg(1106804043)
				local var_179_3 = arg_176_1:FormatText(var_179_2.content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 28 <= 0 and var_179_1 or var_179_1 * (utf8.len(var_179_3) / 28)

				if (28 <= 0 and var_179_1 or var_179_1 * (utf8.len(var_179_3) / 28)) > 0 and var_179_1 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804043", "story_v_side_new_1106804.awb") ~= 0 then
					local var_179_6 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804043", "story_v_side_new_1106804.awb") / 1000

					if var_179_6 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_0
					end

					if var_179_2.prefab_name ~= "" and arg_176_1.actors_[var_179_2.prefab_name] ~= nil then
						local var_179_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_2.prefab_name].transform, "story_v_side_new_1106804", "1106804043", "story_v_side_new_1106804.awb")

						arg_176_1:RecordAudio("1106804043", var_179_7)
						arg_176_1:RecordAudio("1106804043", var_179_7)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804043", "story_v_side_new_1106804.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804043", "story_v_side_new_1106804.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_8 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_8 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_8

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_8 and arg_176_1.time_ < var_179_0 + var_179_8 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1106804044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1106804044
		arg_180_1.duration_ = 6.2

		local var_180_0 = {
			ja = 6.2,
			ko = 2.566,
			zh = 2.566
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1106804045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.25

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:GetWordFromCfg(1106804044)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 10 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 10)

				if (10 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 10)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804044", "story_v_side_new_1106804.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804044", "story_v_side_new_1106804.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_side_new_1106804", "1106804044", "story_v_side_new_1106804.awb")

						arg_180_1:RecordAudio("1106804044", var_183_6)
						arg_180_1:RecordAudio("1106804044", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804044", "story_v_side_new_1106804.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804044", "story_v_side_new_1106804.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1106804045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1106804045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1106804046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1068ui_story"]) and arg_184_1.var_.characterEffect1068ui_story == nil then
				arg_184_1.var_.characterEffect1068ui_story = arg_184_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1068ui_story"]) then
				if arg_184_1.var_.characterEffect1068ui_story and not isNil(arg_184_1.actors_["1068ui_story"]) then
					arg_184_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1068ui_story"]) and arg_184_1.var_.characterEffect1068ui_story then
				arg_184_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.35

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(1106804045).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 14 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 14)

				if (14 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 14)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1106804046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1106804046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1106804047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.275

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(1106804046).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 11 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 11)

				if (11 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 11)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1106804047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1106804047
		arg_192_1.duration_ = 11.13

		local var_192_0 = {
			ja = 8.7,
			ko = 11.133,
			zh = 11.133
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1106804048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.bgs_.F03c == nil then
				local var_195_0 = Object.Instantiate(arg_192_1.paintGo_)

				var_195_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03c")
				var_195_0.name = "F03c"
				var_195_0.transform.parent = arg_192_1.stage_.transform
				var_195_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.bgs_.F03c = var_195_0
			end

			if 2 < arg_192_1.time_ and arg_192_1.time_ <= 2 + arg_195_0 then
				local var_195_1 = arg_192_1.bgs_.F03c

				arg_192_1.bgs_.F03c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_195_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_2 = var_195_1:GetComponent("SpriteRenderer")

				if var_195_2 and var_195_2.sprite then
					local var_195_3 = 2 * (var_195_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_195_1.transform.localScale = Vector3.New(var_195_3 / var_195_2.sprite.bounds.size.y < var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x and var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x or var_195_3 / var_195_2.sprite.bounds.size.y, var_195_3 / var_195_2.sprite.bounds.size.y < var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x and var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x or var_195_3 / var_195_2.sprite.bounds.size.y, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "F03c" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_4 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_5 = 2

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_5 then
				local var_195_6 = Color.New(0, 0, 0)

				var_195_6.a = Mathf.Lerp(0, 1, (arg_192_1.time_ - var_195_4) / var_195_5)
				arg_192_1.mask_.color = var_195_6
			end

			if arg_192_1.time_ >= var_195_4 + var_195_5 and arg_192_1.time_ < var_195_4 + var_195_5 + arg_195_0 then
				local var_195_7 = Color.New(0, 0, 0)

				var_195_7.a = 1
				arg_192_1.mask_.color = var_195_7
			end

			local var_195_8 = 2

			if 2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_9 = 2

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_9 then
				local var_195_10 = Color.New(0, 0, 0)

				var_195_10.a = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_8) / var_195_9)
				arg_192_1.mask_.color = var_195_10
			end

			if arg_192_1.time_ >= var_195_8 + var_195_9 and arg_192_1.time_ < var_195_8 + var_195_9 + arg_195_0 then
				local var_195_11 = Color.New(0, 0, 0)

				arg_192_1.mask_.enabled = false
				var_195_11.a = 0
				arg_192_1.mask_.color = var_195_11
			end

			local var_195_12 = arg_192_1.actors_["1068ui_story"].transform

			if 1.966 < arg_192_1.time_ and arg_192_1.time_ <= 1.966 + arg_195_0 then
				arg_192_1.var_.moveOldPos1068ui_story = var_195_12.localPosition
			end

			local var_195_13 = 0.001

			if 1.966 <= arg_192_1.time_ and arg_192_1.time_ < 1.966 + var_195_13 then
				var_195_12.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 1.966) / var_195_13)
				var_195_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_12.position).x, (manager.ui.mainCamera.transform.position - var_195_12.position).y, (manager.ui.mainCamera.transform.position - var_195_12.position).z)
				var_195_12.localEulerAngles.z = 0
				var_195_12.localEulerAngles.x = 0
				var_195_12.localEulerAngles = var_195_12.localEulerAngles
			end

			if arg_192_1.time_ >= 1.966 + var_195_13 and arg_192_1.time_ < 1.966 + var_195_13 + arg_195_0 then
				var_195_12.localPosition = Vector3.New(0, 100, 0)
				var_195_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_12.position).x, (manager.ui.mainCamera.transform.position - var_195_12.position).y, (manager.ui.mainCamera.transform.position - var_195_12.position).z)
				var_195_12.localEulerAngles.z = 0
				var_195_12.localEulerAngles.x = 0
				var_195_12.localEulerAngles = var_195_12.localEulerAngles
			end

			local var_195_14 = arg_192_1.actors_["1068ui_story"].transform

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= 4 + arg_195_0 then
				arg_192_1.var_.moveOldPos1068ui_story = var_195_14.localPosition
			end

			local var_195_15 = 0.001

			if 4 <= arg_192_1.time_ and arg_192_1.time_ < 4 + var_195_15 then
				var_195_14.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_192_1.time_ - 4) / var_195_15)
				var_195_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_14.position).x, (manager.ui.mainCamera.transform.position - var_195_14.position).y, (manager.ui.mainCamera.transform.position - var_195_14.position).z)
				var_195_14.localEulerAngles.z = 0
				var_195_14.localEulerAngles.x = 0
				var_195_14.localEulerAngles = var_195_14.localEulerAngles
			end

			if arg_192_1.time_ >= 4 + var_195_15 and arg_192_1.time_ < 4 + var_195_15 + arg_195_0 then
				var_195_14.localPosition = Vector3.New(0, -0.95, -5.88)
				var_195_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_14.position).x, (manager.ui.mainCamera.transform.position - var_195_14.position).y, (manager.ui.mainCamera.transform.position - var_195_14.position).z)
				var_195_14.localEulerAngles.z = 0
				var_195_14.localEulerAngles.x = 0
				var_195_14.localEulerAngles = var_195_14.localEulerAngles
			end

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= 4 + arg_195_0 then
				arg_192_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= 4 + arg_195_0 then
				arg_192_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_195_16 = arg_192_1.actors_["1068ui_story"]

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= 4 + arg_195_0 and not isNil(var_195_16) and arg_192_1.var_.characterEffect1068ui_story == nil then
				arg_192_1.var_.characterEffect1068ui_story = var_195_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_17 = 0.2

			if 4 <= arg_192_1.time_ and arg_192_1.time_ < 4 + var_195_17 and not isNil(var_195_16) then
				if arg_192_1.var_.characterEffect1068ui_story and not isNil(var_195_16) then
					arg_192_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 4 + var_195_17 and arg_192_1.time_ < 4 + var_195_17 + arg_195_0 and not isNil(var_195_16) and arg_192_1.var_.characterEffect1068ui_story then
				arg_192_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 1.53333333333333 < arg_192_1.time_ and arg_192_1.time_ <= 1.53333333333333 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_metalbox", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_20 = 4
			local var_195_21 = 0.65

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_20 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_22 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_22:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_23 = arg_192_1:GetWordFromCfg(1106804047)
				local var_195_24 = arg_192_1:FormatText(var_195_23.content)

				arg_192_1.text_.text = var_195_24

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_26 = 26 <= 0 and var_195_21 or var_195_21 * (utf8.len(var_195_24) / 26)

				if (26 <= 0 and var_195_21 or var_195_21 * (utf8.len(var_195_24) / 26)) > 0 and var_195_21 < var_195_26 then
					arg_192_1.talkMaxDuration = var_195_26
					var_195_20 = var_195_20 + 0.3

					if var_195_26 + var_195_20 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_26 + var_195_20
					end
				end

				arg_192_1.text_.text = var_195_24
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804047", "story_v_side_new_1106804.awb") ~= 0 then
					local var_195_27 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804047", "story_v_side_new_1106804.awb") / 1000

					if var_195_27 + var_195_20 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_27 + var_195_20
					end

					if var_195_23.prefab_name ~= "" and arg_192_1.actors_[var_195_23.prefab_name] ~= nil then
						local var_195_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_23.prefab_name].transform, "story_v_side_new_1106804", "1106804047", "story_v_side_new_1106804.awb")

						arg_192_1:RecordAudio("1106804047", var_195_28)
						arg_192_1:RecordAudio("1106804047", var_195_28)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804047", "story_v_side_new_1106804.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804047", "story_v_side_new_1106804.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_29 = var_195_20 + 0.3
			local var_195_30 = math.max(var_195_21, arg_192_1.talkMaxDuration)

			if var_195_20 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_29 + var_195_30 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_29) / var_195_30

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_29 + var_195_30 and arg_192_1.time_ < var_195_29 + var_195_30 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play1106804048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1106804048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1106804049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1068ui_story"]) and arg_198_1.var_.characterEffect1068ui_story == nil then
				arg_198_1.var_.characterEffect1068ui_story = arg_198_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1068ui_story"]) then
				if arg_198_1.var_.characterEffect1068ui_story and not isNil(arg_198_1.actors_["1068ui_story"]) then
					arg_198_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1068ui_story"]) and arg_198_1.var_.characterEffect1068ui_story then
				arg_198_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.825

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1106804048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 33 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 33)

				if (33 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 33)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1106804049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1106804049
		arg_202_1.duration_ = 10.43

		local var_202_0 = {
			ja = 10.433,
			ko = 5.566,
			zh = 5.566
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1106804050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_205_0 = arg_202_1.actors_["1068ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1068ui_story == nil then
				arg_202_1.var_.characterEffect1068ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_1 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 and not isNil(var_205_0) then
				if arg_202_1.var_.characterEffect1068ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1068ui_story then
				arg_202_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_205_3 = 0
			local var_205_4 = 0.7

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_5 = arg_202_1:GetWordFromCfg(1106804049)
				local var_205_6 = arg_202_1:FormatText(var_205_5.content)

				arg_202_1.text_.text = var_205_6

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_8 = 28 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_6) / 28)

				if (28 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_6) / 28)) > 0 and var_205_4 < var_205_8 then
					arg_202_1.talkMaxDuration = var_205_8

					if var_205_8 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_6
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804049", "story_v_side_new_1106804.awb") ~= 0 then
					local var_205_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804049", "story_v_side_new_1106804.awb") / 1000

					if var_205_9 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_3
					end

					if var_205_5.prefab_name ~= "" and arg_202_1.actors_[var_205_5.prefab_name] ~= nil then
						local var_205_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_5.prefab_name].transform, "story_v_side_new_1106804", "1106804049", "story_v_side_new_1106804.awb")

						arg_202_1:RecordAudio("1106804049", var_205_10)
						arg_202_1:RecordAudio("1106804049", var_205_10)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804049", "story_v_side_new_1106804.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804049", "story_v_side_new_1106804.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_11 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_11 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_11

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_11 and arg_202_1.time_ < var_205_3 + var_205_11 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1106804050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1106804050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1106804051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1068ui_story"]) and arg_206_1.var_.characterEffect1068ui_story == nil then
				arg_206_1.var_.characterEffect1068ui_story = arg_206_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1068ui_story"]) then
				if arg_206_1.var_.characterEffect1068ui_story and not isNil(arg_206_1.actors_["1068ui_story"]) then
					arg_206_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_206_1.time_ - 0) / var_209_0)
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1068ui_story"]) and arg_206_1.var_.characterEffect1068ui_story then
				arg_206_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_209_1 = 0
			local var_209_2 = 0.825

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1106804050).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 33 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 33)

				if (33 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 33)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1106804051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1106804051
		arg_210_1.duration_ = 10.2

		local var_210_0 = {
			ja = 10.2,
			ko = 8.933,
			zh = 8.933
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1106804052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1068ui_story"]) and arg_210_1.var_.characterEffect1068ui_story == nil then
				arg_210_1.var_.characterEffect1068ui_story = arg_210_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1068ui_story"]) then
				if arg_210_1.var_.characterEffect1068ui_story and not isNil(arg_210_1.actors_["1068ui_story"]) then
					arg_210_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1068ui_story"]) and arg_210_1.var_.characterEffect1068ui_story then
				arg_210_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_213_2 = 0
			local var_213_3 = 1.05

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(1106804051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 42 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 42)

				if (42 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 42)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804051", "story_v_side_new_1106804.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804051", "story_v_side_new_1106804.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_side_new_1106804", "1106804051", "story_v_side_new_1106804.awb")

						arg_210_1:RecordAudio("1106804051", var_213_9)
						arg_210_1:RecordAudio("1106804051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804051", "story_v_side_new_1106804.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804051", "story_v_side_new_1106804.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1106804052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1106804052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1106804053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1068ui_story"]) and arg_214_1.var_.characterEffect1068ui_story == nil then
				arg_214_1.var_.characterEffect1068ui_story = arg_214_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1068ui_story"]) then
				if arg_214_1.var_.characterEffect1068ui_story and not isNil(arg_214_1.actors_["1068ui_story"]) then
					arg_214_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1068ui_story"]) and arg_214_1.var_.characterEffect1068ui_story then
				arg_214_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.8

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1106804052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 32 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 32)

				if (32 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 32)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1106804053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1106804053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1106804054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.8

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1106804053).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 32 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 32)

				if (32 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 32)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1106804054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1106804054
		arg_222_1.duration_ = 6.8

		local var_222_0 = {
			ja = 5.833,
			ko = 6.8,
			zh = 6.8
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1106804055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_225_0 = arg_222_1.actors_["1068ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1068ui_story == nil then
				arg_222_1.var_.characterEffect1068ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_1 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 and not isNil(var_225_0) then
				if arg_222_1.var_.characterEffect1068ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1068ui_story then
				arg_222_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_225_3 = 0
			local var_225_4 = 0.8

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_5 = arg_222_1:GetWordFromCfg(1106804054)
				local var_225_6 = arg_222_1:FormatText(var_225_5.content)

				arg_222_1.text_.text = var_225_6

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_8 = 32 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_6) / 32)

				if (32 <= 0 and var_225_4 or var_225_4 * (utf8.len(var_225_6) / 32)) > 0 and var_225_4 < var_225_8 then
					arg_222_1.talkMaxDuration = var_225_8

					if var_225_8 + var_225_3 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_3
					end
				end

				arg_222_1.text_.text = var_225_6
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804054", "story_v_side_new_1106804.awb") ~= 0 then
					local var_225_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804054", "story_v_side_new_1106804.awb") / 1000

					if var_225_9 + var_225_3 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_3
					end

					if var_225_5.prefab_name ~= "" and arg_222_1.actors_[var_225_5.prefab_name] ~= nil then
						local var_225_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_5.prefab_name].transform, "story_v_side_new_1106804", "1106804054", "story_v_side_new_1106804.awb")

						arg_222_1:RecordAudio("1106804054", var_225_10)
						arg_222_1:RecordAudio("1106804054", var_225_10)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804054", "story_v_side_new_1106804.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804054", "story_v_side_new_1106804.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_11 = math.max(var_225_4, arg_222_1.talkMaxDuration)

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_11 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_3) / var_225_11

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_3 + var_225_11 and arg_222_1.time_ < var_225_3 + var_225_11 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1106804055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1106804055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1106804056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1068ui_story"]) and arg_226_1.var_.characterEffect1068ui_story == nil then
				arg_226_1.var_.characterEffect1068ui_story = arg_226_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1068ui_story"]) then
				if arg_226_1.var_.characterEffect1068ui_story and not isNil(arg_226_1.actors_["1068ui_story"]) then
					arg_226_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1068ui_story"]) and arg_226_1.var_.characterEffect1068ui_story then
				arg_226_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.3

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(1106804055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 12 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 12)

				if (12 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 12)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1106804056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1106804056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1106804057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.55

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(1106804056).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 22 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 22)

				if (22 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 22)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1106804057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1106804057
		arg_234_1.duration_ = 5.7

		local var_234_0 = {
			ja = 5.7,
			ko = 4.233,
			zh = 4.233
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1106804058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_2")
			end

			local var_237_0 = arg_234_1.actors_["1068ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1068ui_story == nil then
				arg_234_1.var_.characterEffect1068ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_1 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 and not isNil(var_237_0) then
				if arg_234_1.var_.characterEffect1068ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1068ui_story then
				arg_234_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_237_3 = 0
			local var_237_4 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_5 = arg_234_1:GetWordFromCfg(1106804057)
				local var_237_6 = arg_234_1:FormatText(var_237_5.content)

				arg_234_1.text_.text = var_237_6

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_8 = 18 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_6) / 18)

				if (18 <= 0 and var_237_4 or var_237_4 * (utf8.len(var_237_6) / 18)) > 0 and var_237_4 < var_237_8 then
					arg_234_1.talkMaxDuration = var_237_8

					if var_237_8 + var_237_3 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_3
					end
				end

				arg_234_1.text_.text = var_237_6
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804057", "story_v_side_new_1106804.awb") ~= 0 then
					local var_237_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804057", "story_v_side_new_1106804.awb") / 1000

					if var_237_9 + var_237_3 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_3
					end

					if var_237_5.prefab_name ~= "" and arg_234_1.actors_[var_237_5.prefab_name] ~= nil then
						local var_237_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_5.prefab_name].transform, "story_v_side_new_1106804", "1106804057", "story_v_side_new_1106804.awb")

						arg_234_1:RecordAudio("1106804057", var_237_10)
						arg_234_1:RecordAudio("1106804057", var_237_10)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804057", "story_v_side_new_1106804.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804057", "story_v_side_new_1106804.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_11 = math.max(var_237_4, arg_234_1.talkMaxDuration)

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_11 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_3) / var_237_11

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_3 + var_237_11 and arg_234_1.time_ < var_237_3 + var_237_11 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1106804058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1106804058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1106804059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1068ui_story"]) and arg_238_1.var_.characterEffect1068ui_story == nil then
				arg_238_1.var_.characterEffect1068ui_story = arg_238_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1068ui_story"]) then
				if arg_238_1.var_.characterEffect1068ui_story and not isNil(arg_238_1.actors_["1068ui_story"]) then
					arg_238_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1068ui_story"]) and arg_238_1.var_.characterEffect1068ui_story then
				arg_238_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.325

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1106804058).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 13 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 13)

				if (13 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 13)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1106804059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1106804059
		arg_242_1.duration_ = 6.67

		local var_242_0 = {
			ja = 6.666,
			ko = 3.166,
			zh = 3.166
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1106804060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_245_0 = arg_242_1.actors_["1068ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1068ui_story == nil then
				arg_242_1.var_.characterEffect1068ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_1 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 and not isNil(var_245_0) then
				if arg_242_1.var_.characterEffect1068ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1068ui_story then
				arg_242_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_245_3 = 0
			local var_245_4 = 0.425

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_3 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_5 = arg_242_1:GetWordFromCfg(1106804059)
				local var_245_6 = arg_242_1:FormatText(var_245_5.content)

				arg_242_1.text_.text = var_245_6

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_8 = 17 <= 0 and var_245_4 or var_245_4 * (utf8.len(var_245_6) / 17)

				if (17 <= 0 and var_245_4 or var_245_4 * (utf8.len(var_245_6) / 17)) > 0 and var_245_4 < var_245_8 then
					arg_242_1.talkMaxDuration = var_245_8

					if var_245_8 + var_245_3 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_3
					end
				end

				arg_242_1.text_.text = var_245_6
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804059", "story_v_side_new_1106804.awb") ~= 0 then
					local var_245_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804059", "story_v_side_new_1106804.awb") / 1000

					if var_245_9 + var_245_3 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_3
					end

					if var_245_5.prefab_name ~= "" and arg_242_1.actors_[var_245_5.prefab_name] ~= nil then
						local var_245_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_5.prefab_name].transform, "story_v_side_new_1106804", "1106804059", "story_v_side_new_1106804.awb")

						arg_242_1:RecordAudio("1106804059", var_245_10)
						arg_242_1:RecordAudio("1106804059", var_245_10)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804059", "story_v_side_new_1106804.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804059", "story_v_side_new_1106804.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_11 = math.max(var_245_4, arg_242_1.talkMaxDuration)

			if var_245_3 <= arg_242_1.time_ and arg_242_1.time_ < var_245_3 + var_245_11 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_3) / var_245_11

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_3 + var_245_11 and arg_242_1.time_ < var_245_3 + var_245_11 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1106804060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1106804060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1106804061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1068ui_story"]) and arg_246_1.var_.characterEffect1068ui_story == nil then
				arg_246_1.var_.characterEffect1068ui_story = arg_246_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1068ui_story"]) then
				if arg_246_1.var_.characterEffect1068ui_story and not isNil(arg_246_1.actors_["1068ui_story"]) then
					arg_246_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1068ui_story"]) and arg_246_1.var_.characterEffect1068ui_story then
				arg_246_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 0.1

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
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

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1106804060).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 4 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 4)

				if (4 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 4)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1106804061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1106804061
		arg_250_1.duration_ = 9

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1106804062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_0 = 2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				local var_253_1 = Color.New(0, 0, 0)

				var_253_1.a = Mathf.Lerp(0, 1, (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.mask_.color = var_253_1
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				local var_253_2 = Color.New(0, 0, 0)

				var_253_2.a = 1
				arg_250_1.mask_.color = var_253_2
			end

			local var_253_3 = 2

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_4 = 2

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_4 then
				local var_253_5 = Color.New(0, 0, 0)

				var_253_5.a = Mathf.Lerp(1, 0, (arg_250_1.time_ - var_253_3) / var_253_4)
				arg_250_1.mask_.color = var_253_5
			end

			if arg_250_1.time_ >= var_253_3 + var_253_4 and arg_250_1.time_ < var_253_3 + var_253_4 + arg_253_0 then
				local var_253_6 = Color.New(0, 0, 0)

				arg_250_1.mask_.enabled = false
				var_253_6.a = 0
				arg_250_1.mask_.color = var_253_6
			end

			local var_253_7 = arg_250_1.actors_["1068ui_story"].transform

			if 1.966 < arg_250_1.time_ and arg_250_1.time_ <= 1.966 + arg_253_0 then
				arg_250_1.var_.moveOldPos1068ui_story = var_253_7.localPosition
			end

			local var_253_8 = 0.001

			if 1.966 <= arg_250_1.time_ and arg_250_1.time_ < 1.966 + var_253_8 then
				var_253_7.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 1.966) / var_253_8)
				var_253_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_7.position).x, (manager.ui.mainCamera.transform.position - var_253_7.position).y, (manager.ui.mainCamera.transform.position - var_253_7.position).z)
				var_253_7.localEulerAngles.z = 0
				var_253_7.localEulerAngles.x = 0
				var_253_7.localEulerAngles = var_253_7.localEulerAngles
			end

			if arg_250_1.time_ >= 1.966 + var_253_8 and arg_250_1.time_ < 1.966 + var_253_8 + arg_253_0 then
				var_253_7.localPosition = Vector3.New(0, 100, 0)
				var_253_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_253_7.position).x, (manager.ui.mainCamera.transform.position - var_253_7.position).y, (manager.ui.mainCamera.transform.position - var_253_7.position).z)
				var_253_7.localEulerAngles.z = 0
				var_253_7.localEulerAngles.x = 0
				var_253_7.localEulerAngles = var_253_7.localEulerAngles
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_9 = 4
			local var_253_10 = 0.05

			if 4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_9 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_11 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_11:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_12 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1106804061).content)

				arg_250_1.text_.text = var_253_12

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_14 = 2 <= 0 and var_253_10 or var_253_10 * (utf8.len(var_253_12) / 2)

				if (2 <= 0 and var_253_10 or var_253_10 * (utf8.len(var_253_12) / 2)) > 0 and var_253_10 < var_253_14 then
					arg_250_1.talkMaxDuration = var_253_14
					var_253_9 = var_253_9 + 0.3

					if var_253_14 + var_253_9 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_9
					end
				end

				arg_250_1.text_.text = var_253_12
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_15 = var_253_9 + 0.3
			local var_253_16 = math.max(var_253_10, arg_250_1.talkMaxDuration)

			if var_253_9 + 0.3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_15 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_15) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_15 + var_253_16 and arg_250_1.time_ < var_253_15 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play1106804062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1106804062
		arg_256_1.duration_ = 4.13

		local var_256_0 = {
			ja = 4.133,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1106804063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1068ui_story = arg_256_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).z)
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles = arg_256_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_256_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1068ui_story"].transform.position).z)
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1068ui_story"].transform.localEulerAngles = arg_256_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_259_1 = arg_256_1.actors_["1068ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1068ui_story == nil then
				arg_256_1.var_.characterEffect1068ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect1068ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1068ui_story then
				arg_256_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_259_4 = 0
			local var_259_5 = 0.175

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(1106804062)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 7 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 7)

				if (7 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 7)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804062", "story_v_side_new_1106804.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804062", "story_v_side_new_1106804.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_side_new_1106804", "1106804062", "story_v_side_new_1106804.awb")

						arg_256_1:RecordAudio("1106804062", var_259_11)
						arg_256_1:RecordAudio("1106804062", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804062", "story_v_side_new_1106804.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804062", "story_v_side_new_1106804.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play1106804063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1106804063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1106804064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1068ui_story"]) and arg_260_1.var_.characterEffect1068ui_story == nil then
				arg_260_1.var_.characterEffect1068ui_story = arg_260_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1068ui_story"]) then
				if arg_260_1.var_.characterEffect1068ui_story and not isNil(arg_260_1.actors_["1068ui_story"]) then
					arg_260_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1068ui_story"]) and arg_260_1.var_.characterEffect1068ui_story then
				arg_260_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.625

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1106804063).content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 25 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 25)

				if (25 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 25)) > 0 and var_263_2 < var_263_5 then
					arg_260_1.talkMaxDuration = var_263_5

					if var_263_5 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + var_263_1
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_6 = math.max(var_263_2, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_6 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_1) / var_263_6

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_6 and arg_260_1.time_ < var_263_1 + var_263_6 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1106804064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1106804064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1106804065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.825

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(1106804064).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 33 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 33)

				if (33 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 33)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1106804065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1106804065
		arg_268_1.duration_ = 8.47

		local var_268_0 = {
			ja = 8.466,
			ko = 6.166,
			zh = 6.166
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1106804066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1068ui_story"]) and arg_268_1.var_.characterEffect1068ui_story == nil then
				arg_268_1.var_.characterEffect1068ui_story = arg_268_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1068ui_story"]) then
				if arg_268_1.var_.characterEffect1068ui_story and not isNil(arg_268_1.actors_["1068ui_story"]) then
					arg_268_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1068ui_story"]) and arg_268_1.var_.characterEffect1068ui_story then
				arg_268_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_271_2 = 0
			local var_271_3 = 0.825

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_4 = arg_268_1:GetWordFromCfg(1106804065)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 33 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 33)

				if (33 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 33)) > 0 and var_271_3 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804065", "story_v_side_new_1106804.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804065", "story_v_side_new_1106804.awb") / 1000

					if var_271_8 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_2
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_side_new_1106804", "1106804065", "story_v_side_new_1106804.awb")

						arg_268_1:RecordAudio("1106804065", var_271_9)
						arg_268_1:RecordAudio("1106804065", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804065", "story_v_side_new_1106804.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804065", "story_v_side_new_1106804.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_10 and arg_268_1.time_ < var_271_2 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1106804066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1106804066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1106804067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1068ui_story"]) and arg_272_1.var_.characterEffect1068ui_story == nil then
				arg_272_1.var_.characterEffect1068ui_story = arg_272_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.2

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1068ui_story"]) then
				if arg_272_1.var_.characterEffect1068ui_story and not isNil(arg_272_1.actors_["1068ui_story"]) then
					arg_272_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_0)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1068ui_story"]) and arg_272_1.var_.characterEffect1068ui_story then
				arg_272_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_275_1 = 0
			local var_275_2 = 1.1

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(1106804066).content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 44 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 44)

				if (44 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 44)) > 0 and var_275_2 < var_275_5 then
					arg_272_1.talkMaxDuration = var_275_5

					if var_275_5 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_6 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_6 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_6

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_6 and arg_272_1.time_ < var_275_1 + var_275_6 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1106804067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1106804067
		arg_276_1.duration_ = 6.43

		local var_276_0 = {
			ja = 6.433,
			ko = 2.233,
			zh = 2.233
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1106804068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1068ui_story"]) and arg_276_1.var_.characterEffect1068ui_story == nil then
				arg_276_1.var_.characterEffect1068ui_story = arg_276_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1068ui_story"]) then
				if arg_276_1.var_.characterEffect1068ui_story and not isNil(arg_276_1.actors_["1068ui_story"]) then
					arg_276_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1068ui_story"]) and arg_276_1.var_.characterEffect1068ui_story then
				arg_276_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_279_2 = 0
			local var_279_3 = 0.175

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(1106804067)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 7 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 7)

				if (7 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 7)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804067", "story_v_side_new_1106804.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804067", "story_v_side_new_1106804.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_side_new_1106804", "1106804067", "story_v_side_new_1106804.awb")

						arg_276_1:RecordAudio("1106804067", var_279_9)
						arg_276_1:RecordAudio("1106804067", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804067", "story_v_side_new_1106804.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804067", "story_v_side_new_1106804.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1106804068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1106804068
		arg_280_1.duration_ = 7.57

		local var_280_0 = {
			ja = 7.566,
			ko = 4.1,
			zh = 4.1
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1106804069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.55

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:GetWordFromCfg(1106804068)
				local var_283_2 = arg_280_1:FormatText(var_283_1.content)

				arg_280_1.text_.text = var_283_2

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 22 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 22)

				if (22 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 22)) > 0 and var_283_0 < var_283_4 then
					arg_280_1.talkMaxDuration = var_283_4

					if var_283_4 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_4 + 0
					end
				end

				arg_280_1.text_.text = var_283_2
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804068", "story_v_side_new_1106804.awb") ~= 0 then
					local var_283_5 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804068", "story_v_side_new_1106804.awb") / 1000

					if var_283_5 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + 0
					end

					if var_283_1.prefab_name ~= "" and arg_280_1.actors_[var_283_1.prefab_name] ~= nil then
						local var_283_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_1.prefab_name].transform, "story_v_side_new_1106804", "1106804068", "story_v_side_new_1106804.awb")

						arg_280_1:RecordAudio("1106804068", var_283_6)
						arg_280_1:RecordAudio("1106804068", var_283_6)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804068", "story_v_side_new_1106804.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804068", "story_v_side_new_1106804.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1106804069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1106804069
		arg_284_1.duration_ = 11.13

		local var_284_0 = {
			ja = 11.133,
			ko = 9.3,
			zh = 9.3
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1106804070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 2 < arg_284_1.time_ and arg_284_1.time_ <= 2 + arg_287_0 then
				arg_284_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_287_0 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_1 = 1

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_1 then
				local var_287_2 = Color.New(0, 0, 0)

				var_287_2.a = Mathf.Lerp(0, 1, (arg_284_1.time_ - var_287_0) / var_287_1)
				arg_284_1.mask_.color = var_287_2
			end

			if arg_284_1.time_ >= var_287_0 + var_287_1 and arg_284_1.time_ < var_287_0 + var_287_1 + arg_287_0 then
				local var_287_3 = Color.New(0, 0, 0)

				var_287_3.a = 1
				arg_284_1.mask_.color = var_287_3
			end

			local var_287_4 = 1

			if 1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_5 = 1

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_5 then
				local var_287_6 = Color.New(0, 0, 0)

				var_287_6.a = Mathf.Lerp(1, 0, (arg_284_1.time_ - var_287_4) / var_287_5)
				arg_284_1.mask_.color = var_287_6
			end

			if arg_284_1.time_ >= var_287_4 + var_287_5 and arg_284_1.time_ < var_287_4 + var_287_5 + arg_287_0 then
				local var_287_7 = Color.New(0, 0, 0)

				arg_284_1.mask_.enabled = false
				var_287_7.a = 0
				arg_284_1.mask_.color = var_287_7
			end

			if 0.133333333333333 < arg_284_1.time_ and arg_284_1.time_ <= 0.133333333333333 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_drill", "")
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_9 = 2
			local var_287_10 = 0.85

			if 2 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_11 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_11:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_12 = arg_284_1:GetWordFromCfg(1106804069)
				local var_287_13 = arg_284_1:FormatText(var_287_12.content)

				arg_284_1.text_.text = var_287_13

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_15 = 34 <= 0 and var_287_10 or var_287_10 * (utf8.len(var_287_13) / 34)

				if (34 <= 0 and var_287_10 or var_287_10 * (utf8.len(var_287_13) / 34)) > 0 and var_287_10 < var_287_15 then
					arg_284_1.talkMaxDuration = var_287_15
					var_287_9 = var_287_9 + 0.3

					if var_287_15 + var_287_9 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_15 + var_287_9
					end
				end

				arg_284_1.text_.text = var_287_13
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804069", "story_v_side_new_1106804.awb") ~= 0 then
					local var_287_16 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804069", "story_v_side_new_1106804.awb") / 1000

					if var_287_16 + var_287_9 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_16 + var_287_9
					end

					if var_287_12.prefab_name ~= "" and arg_284_1.actors_[var_287_12.prefab_name] ~= nil then
						local var_287_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_12.prefab_name].transform, "story_v_side_new_1106804", "1106804069", "story_v_side_new_1106804.awb")

						arg_284_1:RecordAudio("1106804069", var_287_17)
						arg_284_1:RecordAudio("1106804069", var_287_17)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804069", "story_v_side_new_1106804.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804069", "story_v_side_new_1106804.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_18 = var_287_9 + 0.3
			local var_287_19 = math.max(var_287_10, arg_284_1.talkMaxDuration)

			if var_287_9 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_18 + var_287_19 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_18) / var_287_19

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_18 + var_287_19 and arg_284_1.time_ < var_287_18 + var_287_19 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1106804070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1106804070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1106804071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1068ui_story"]) and arg_290_1.var_.characterEffect1068ui_story == nil then
				arg_290_1.var_.characterEffect1068ui_story = arg_290_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1068ui_story"]) then
				if arg_290_1.var_.characterEffect1068ui_story and not isNil(arg_290_1.actors_["1068ui_story"]) then
					arg_290_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1068ui_story"]) and arg_290_1.var_.characterEffect1068ui_story then
				arg_290_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.475

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1106804070).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 19 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 19)

				if (19 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 19)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1106804071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1106804071
		arg_294_1.duration_ = 5.93

		local var_294_0 = {
			ja = 5.933,
			ko = 4.3,
			zh = 4.3
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1106804072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1068ui_story"]) and arg_294_1.var_.characterEffect1068ui_story == nil then
				arg_294_1.var_.characterEffect1068ui_story = arg_294_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1068ui_story"]) then
				if arg_294_1.var_.characterEffect1068ui_story and not isNil(arg_294_1.actors_["1068ui_story"]) then
					arg_294_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1068ui_story"]) and arg_294_1.var_.characterEffect1068ui_story then
				arg_294_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_297_2 = 0
			local var_297_3 = 0.275

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_2 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_4 = arg_294_1:GetWordFromCfg(1106804071)
				local var_297_5 = arg_294_1:FormatText(var_297_4.content)

				arg_294_1.text_.text = var_297_5

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_7 = 11 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 11)

				if (11 <= 0 and var_297_3 or var_297_3 * (utf8.len(var_297_5) / 11)) > 0 and var_297_3 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_2
					end
				end

				arg_294_1.text_.text = var_297_5
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804071", "story_v_side_new_1106804.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804071", "story_v_side_new_1106804.awb") / 1000

					if var_297_8 + var_297_2 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_2
					end

					if var_297_4.prefab_name ~= "" and arg_294_1.actors_[var_297_4.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_4.prefab_name].transform, "story_v_side_new_1106804", "1106804071", "story_v_side_new_1106804.awb")

						arg_294_1:RecordAudio("1106804071", var_297_9)
						arg_294_1:RecordAudio("1106804071", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804071", "story_v_side_new_1106804.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804071", "story_v_side_new_1106804.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_3, arg_294_1.talkMaxDuration)

			if var_297_2 <= arg_294_1.time_ and arg_294_1.time_ < var_297_2 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_2) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_2 + var_297_10 and arg_294_1.time_ < var_297_2 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1106804072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1106804072
		arg_298_1.duration_ = 9

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1106804073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if arg_298_1.bgs_.F03_2 == nil then
				local var_301_0 = Object.Instantiate(arg_298_1.paintGo_)

				var_301_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03_2")
				var_301_0.name = "F03_2"
				var_301_0.transform.parent = arg_298_1.stage_.transform
				var_301_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_298_1.bgs_.F03_2 = var_301_0
			end

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= 2 + arg_301_0 then
				local var_301_1 = arg_298_1.bgs_.F03_2

				arg_298_1.bgs_.F03_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_301_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_301_2 = var_301_1:GetComponent("SpriteRenderer")

				if var_301_2 and var_301_2.sprite then
					local var_301_3 = 2 * (var_301_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_301_1.transform.localScale = Vector3.New(var_301_3 / var_301_2.sprite.bounds.size.y < var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x and var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x or var_301_3 / var_301_2.sprite.bounds.size.y, var_301_3 / var_301_2.sprite.bounds.size.y < var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x and var_301_3 * manager.ui.mainCameraCom_.aspect / var_301_2.sprite.bounds.size.x or var_301_3 / var_301_2.sprite.bounds.size.y, 0)
				end

				for iter_301_0, iter_301_1 in pairs(arg_298_1.bgs_) do
					if iter_301_0 ~= "F03_2" then
						iter_301_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_301_4 = 0

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_5 = 2

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_5 then
				local var_301_6 = Color.New(0, 0, 0)

				var_301_6.a = Mathf.Lerp(0, 1, (arg_298_1.time_ - var_301_4) / var_301_5)
				arg_298_1.mask_.color = var_301_6
			end

			if arg_298_1.time_ >= var_301_4 + var_301_5 and arg_298_1.time_ < var_301_4 + var_301_5 + arg_301_0 then
				local var_301_7 = Color.New(0, 0, 0)

				var_301_7.a = 1
				arg_298_1.mask_.color = var_301_7
			end

			local var_301_8 = 2

			if 2 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.mask_.enabled = true
				arg_298_1.mask_.raycastTarget = true

				arg_298_1:SetGaussion(false)
			end

			local var_301_9 = 2

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_9 then
				local var_301_10 = Color.New(0, 0, 0)

				var_301_10.a = Mathf.Lerp(1, 0, (arg_298_1.time_ - var_301_8) / var_301_9)
				arg_298_1.mask_.color = var_301_10
			end

			if arg_298_1.time_ >= var_301_8 + var_301_9 and arg_298_1.time_ < var_301_8 + var_301_9 + arg_301_0 then
				local var_301_11 = Color.New(0, 0, 0)

				arg_298_1.mask_.enabled = false
				var_301_11.a = 0
				arg_298_1.mask_.color = var_301_11
			end

			local var_301_12 = arg_298_1.actors_["1068ui_story"].transform

			if 1.966 < arg_298_1.time_ and arg_298_1.time_ <= 1.966 + arg_301_0 then
				arg_298_1.var_.moveOldPos1068ui_story = var_301_12.localPosition
			end

			local var_301_13 = 0.001

			if 1.966 <= arg_298_1.time_ and arg_298_1.time_ < 1.966 + var_301_13 then
				var_301_12.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_298_1.time_ - 1.966) / var_301_13)
				var_301_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_12.position).x, (manager.ui.mainCamera.transform.position - var_301_12.position).y, (manager.ui.mainCamera.transform.position - var_301_12.position).z)
				var_301_12.localEulerAngles.z = 0
				var_301_12.localEulerAngles.x = 0
				var_301_12.localEulerAngles = var_301_12.localEulerAngles
			end

			if arg_298_1.time_ >= 1.966 + var_301_13 and arg_298_1.time_ < 1.966 + var_301_13 + arg_301_0 then
				var_301_12.localPosition = Vector3.New(0, 100, 0)
				var_301_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_301_12.position).x, (manager.ui.mainCamera.transform.position - var_301_12.position).y, (manager.ui.mainCamera.transform.position - var_301_12.position).z)
				var_301_12.localEulerAngles.z = 0
				var_301_12.localEulerAngles.x = 0
				var_301_12.localEulerAngles = var_301_12.localEulerAngles
			end

			if arg_298_1.frameCnt_ <= 1 then
				arg_298_1.dialog_:SetActive(false)
			end

			local var_301_14 = 4
			local var_301_15 = 0.95

			if 4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_14 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0

				arg_298_1.dialog_:SetActive(true)

				arg_298_1.dialogCg_.alpha = 0

				local var_301_16 = LeanTween.value(arg_298_1.dialog_, 0, 1, 0.3)

				var_301_16:setOnUpdate(LuaHelper.FloatAction(function(arg_302_0)
					arg_298_1.dialogCg_.alpha = arg_302_0
				end))
				var_301_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_298_1.dialog_)
					var_301_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_298_1.duration_ = arg_298_1.duration_ + 0.3

				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_17 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(1106804072).content)

				arg_298_1.text_.text = var_301_17

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_19 = 38 <= 0 and var_301_15 or var_301_15 * (utf8.len(var_301_17) / 38)

				if (38 <= 0 and var_301_15 or var_301_15 * (utf8.len(var_301_17) / 38)) > 0 and var_301_15 < var_301_19 then
					arg_298_1.talkMaxDuration = var_301_19
					var_301_14 = var_301_14 + 0.3

					if var_301_19 + var_301_14 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_19 + var_301_14
					end
				end

				arg_298_1.text_.text = var_301_17
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_20 = var_301_14 + 0.3
			local var_301_21 = math.max(var_301_15, arg_298_1.talkMaxDuration)

			if var_301_14 + 0.3 <= arg_298_1.time_ and arg_298_1.time_ < var_301_20 + var_301_21 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_20) / var_301_21

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_20 + var_301_21 and arg_298_1.time_ < var_301_20 + var_301_21 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play1106804073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1106804073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1106804074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.55

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(1106804073).content)

				arg_304_1.text_.text = var_307_1

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_3 = 22 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 22)

				if (22 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_1) / 22)) > 0 and var_307_0 < var_307_3 then
					arg_304_1.talkMaxDuration = var_307_3

					if var_307_3 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_3 + 0
					end
				end

				arg_304_1.text_.text = var_307_1
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_4 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_4

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1106804074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1106804074
		arg_308_1.duration_ = 13.37

		local var_308_0 = {
			ja = 13.366,
			ko = 5.533,
			zh = 5.533
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
				arg_308_0:Play1106804075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1068ui_story = arg_308_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).z)
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles = arg_308_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_308_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1068ui_story"].transform.position).z)
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1068ui_story"].transform.localEulerAngles = arg_308_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_311_1 = arg_308_1.actors_["1068ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1068ui_story == nil then
				arg_308_1.var_.characterEffect1068ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect1068ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1068ui_story then
				arg_308_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_311_4 = 0
			local var_311_5 = 0.725

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_6 = arg_308_1:GetWordFromCfg(1106804074)
				local var_311_7 = arg_308_1:FormatText(var_311_6.content)

				arg_308_1.text_.text = var_311_7

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_9 = 29 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 29)

				if (29 <= 0 and var_311_5 or var_311_5 * (utf8.len(var_311_7) / 29)) > 0 and var_311_5 < var_311_9 then
					arg_308_1.talkMaxDuration = var_311_9

					if var_311_9 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_9 + var_311_4
					end
				end

				arg_308_1.text_.text = var_311_7
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804074", "story_v_side_new_1106804.awb") ~= 0 then
					local var_311_10 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804074", "story_v_side_new_1106804.awb") / 1000

					if var_311_10 + var_311_4 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_4
					end

					if var_311_6.prefab_name ~= "" and arg_308_1.actors_[var_311_6.prefab_name] ~= nil then
						local var_311_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_6.prefab_name].transform, "story_v_side_new_1106804", "1106804074", "story_v_side_new_1106804.awb")

						arg_308_1:RecordAudio("1106804074", var_311_11)
						arg_308_1:RecordAudio("1106804074", var_311_11)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804074", "story_v_side_new_1106804.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804074", "story_v_side_new_1106804.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_12 = math.max(var_311_5, arg_308_1.talkMaxDuration)

			if var_311_4 <= arg_308_1.time_ and arg_308_1.time_ < var_311_4 + var_311_12 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_4) / var_311_12

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_4 + var_311_12 and arg_308_1.time_ < var_311_4 + var_311_12 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
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
	Play1106804075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1106804075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1106804076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1068ui_story"]) and arg_312_1.var_.characterEffect1068ui_story == nil then
				arg_312_1.var_.characterEffect1068ui_story = arg_312_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1068ui_story"]) then
				if arg_312_1.var_.characterEffect1068ui_story and not isNil(arg_312_1.actors_["1068ui_story"]) then
					arg_312_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_312_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_0)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1068ui_story"]) and arg_312_1.var_.characterEffect1068ui_story then
				arg_312_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_312_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_315_1 = 0
			local var_315_2 = 0.425

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(1106804075).content)

				arg_312_1.text_.text = var_315_3

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 17 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 17)

				if (17 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_3) / 17)) > 0 and var_315_2 < var_315_5 then
					arg_312_1.talkMaxDuration = var_315_5

					if var_315_5 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_3
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_6 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_6 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_6

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_6 and arg_312_1.time_ < var_315_1 + var_315_6 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play1106804076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1106804076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1106804077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.45

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1106804076).content)

				arg_316_1.text_.text = var_319_1

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_3 = 18 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 18)

				if (18 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_1) / 18)) > 0 and var_319_0 < var_319_3 then
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
	Play1106804077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1106804077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1106804078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.525

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1106804077).content)

				arg_320_1.text_.text = var_323_1

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_3 = 21 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 21)

				if (21 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_1) / 21)) > 0 and var_323_0 < var_323_3 then
					arg_320_1.talkMaxDuration = var_323_3

					if var_323_3 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_3 + 0
					end
				end

				arg_320_1.text_.text = var_323_1
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_4 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_4

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1106804078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1106804078
		arg_324_1.duration_ = 3.2

		local var_324_0 = {
			ja = 3.2,
			ko = 2.9,
			zh = 2.9
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
				arg_324_0:Play1106804079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_327_0 = arg_324_1.actors_["1068ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1068ui_story == nil then
				arg_324_1.var_.characterEffect1068ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_1 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_1 and not isNil(var_327_0) then
				if arg_324_1.var_.characterEffect1068ui_story and not isNil(var_327_0) then
					arg_324_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_1 and arg_324_1.time_ < 0 + var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect1068ui_story then
				arg_324_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_327_3 = 0
			local var_327_4 = 0.275

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_5 = arg_324_1:GetWordFromCfg(1106804078)
				local var_327_6 = arg_324_1:FormatText(var_327_5.content)

				arg_324_1.text_.text = var_327_6

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_8 = 11 <= 0 and var_327_4 or var_327_4 * (utf8.len(var_327_6) / 11)

				if (11 <= 0 and var_327_4 or var_327_4 * (utf8.len(var_327_6) / 11)) > 0 and var_327_4 < var_327_8 then
					arg_324_1.talkMaxDuration = var_327_8

					if var_327_8 + var_327_3 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_8 + var_327_3
					end
				end

				arg_324_1.text_.text = var_327_6
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804078", "story_v_side_new_1106804.awb") ~= 0 then
					local var_327_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804078", "story_v_side_new_1106804.awb") / 1000

					if var_327_9 + var_327_3 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_9 + var_327_3
					end

					if var_327_5.prefab_name ~= "" and arg_324_1.actors_[var_327_5.prefab_name] ~= nil then
						local var_327_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_5.prefab_name].transform, "story_v_side_new_1106804", "1106804078", "story_v_side_new_1106804.awb")

						arg_324_1:RecordAudio("1106804078", var_327_10)
						arg_324_1:RecordAudio("1106804078", var_327_10)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804078", "story_v_side_new_1106804.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804078", "story_v_side_new_1106804.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_11 = math.max(var_327_4, arg_324_1.talkMaxDuration)

			if var_327_3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_3 + var_327_11 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_3) / var_327_11

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_3 + var_327_11 and arg_324_1.time_ < var_327_3 + var_327_11 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play1106804079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1106804079
		arg_328_1.duration_ = 12.77

		local var_328_0 = {
			ja = 12.766,
			ko = 7.866,
			zh = 7.866
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
				arg_328_0:Play1106804080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_331_0 = arg_328_1.actors_["1068ui_story"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1068ui_story == nil then
				arg_328_1.var_.characterEffect1068ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_1 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_1 and not isNil(var_331_0) then
				if arg_328_1.var_.characterEffect1068ui_story and not isNil(var_331_0) then
					arg_328_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_1 and arg_328_1.time_ < 0 + var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect1068ui_story then
				arg_328_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action2_1")
			end

			local var_331_3 = 0
			local var_331_4 = 1.025

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_5 = arg_328_1:GetWordFromCfg(1106804079)
				local var_331_6 = arg_328_1:FormatText(var_331_5.content)

				arg_328_1.text_.text = var_331_6

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_8 = 41 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_6) / 41)

				if (41 <= 0 and var_331_4 or var_331_4 * (utf8.len(var_331_6) / 41)) > 0 and var_331_4 < var_331_8 then
					arg_328_1.talkMaxDuration = var_331_8

					if var_331_8 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_3
					end
				end

				arg_328_1.text_.text = var_331_6
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804079", "story_v_side_new_1106804.awb") ~= 0 then
					local var_331_9 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804079", "story_v_side_new_1106804.awb") / 1000

					if var_331_9 + var_331_3 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_3
					end

					if var_331_5.prefab_name ~= "" and arg_328_1.actors_[var_331_5.prefab_name] ~= nil then
						local var_331_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_5.prefab_name].transform, "story_v_side_new_1106804", "1106804079", "story_v_side_new_1106804.awb")

						arg_328_1:RecordAudio("1106804079", var_331_10)
						arg_328_1:RecordAudio("1106804079", var_331_10)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804079", "story_v_side_new_1106804.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804079", "story_v_side_new_1106804.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_11 = math.max(var_331_4, arg_328_1.talkMaxDuration)

			if var_331_3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_3 + var_331_11 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_3) / var_331_11

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_3 + var_331_11 and arg_328_1.time_ < var_331_3 + var_331_11 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play1106804080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1106804080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1106804081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1068ui_story"]) and arg_332_1.var_.characterEffect1068ui_story == nil then
				arg_332_1.var_.characterEffect1068ui_story = arg_332_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1068ui_story"]) then
				if arg_332_1.var_.characterEffect1068ui_story and not isNil(arg_332_1.actors_["1068ui_story"]) then
					arg_332_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1068ui_story"]) and arg_332_1.var_.characterEffect1068ui_story then
				arg_332_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_335_1 = 0
			local var_335_2 = 0.275

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(1106804080).content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 11 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 11)

				if (11 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_3) / 11)) > 0 and var_335_2 < var_335_5 then
					arg_332_1.talkMaxDuration = var_335_5

					if var_335_5 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_5 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_6 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_6 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_6

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_6 and arg_332_1.time_ < var_335_1 + var_335_6 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1106804081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1106804081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1106804082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.4

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(1106804081).content)

				arg_336_1.text_.text = var_339_1

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_3 = 16 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 16)

				if (16 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 16)) > 0 and var_339_0 < var_339_3 then
					arg_336_1.talkMaxDuration = var_339_3

					if var_339_3 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_3 + 0
					end
				end

				arg_336_1.text_.text = var_339_1
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_4 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_4

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1106804082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1106804082
		arg_340_1.duration_ = 12.17

		local var_340_0 = {
			ja = 12.166,
			ko = 9.533,
			zh = 9.533
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
				arg_340_0:Play1106804083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1068ui_story"]) and arg_340_1.var_.characterEffect1068ui_story == nil then
				arg_340_1.var_.characterEffect1068ui_story = arg_340_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1068ui_story"]) then
				if arg_340_1.var_.characterEffect1068ui_story and not isNil(arg_340_1.actors_["1068ui_story"]) then
					arg_340_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1068ui_story"]) and arg_340_1.var_.characterEffect1068ui_story then
				arg_340_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068actionlink/1068action424")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_343_2 = 0
			local var_343_3 = 1.3

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_4 = arg_340_1:GetWordFromCfg(1106804082)
				local var_343_5 = arg_340_1:FormatText(var_343_4.content)

				arg_340_1.text_.text = var_343_5

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 52 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 52)

				if (52 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 52)) > 0 and var_343_3 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_5
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804082", "story_v_side_new_1106804.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804082", "story_v_side_new_1106804.awb") / 1000

					if var_343_8 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_2
					end

					if var_343_4.prefab_name ~= "" and arg_340_1.actors_[var_343_4.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_4.prefab_name].transform, "story_v_side_new_1106804", "1106804082", "story_v_side_new_1106804.awb")

						arg_340_1:RecordAudio("1106804082", var_343_9)
						arg_340_1:RecordAudio("1106804082", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804082", "story_v_side_new_1106804.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804082", "story_v_side_new_1106804.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_10 and arg_340_1.time_ < var_343_2 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1106804083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1106804083
		arg_344_1.duration_ = 8.07

		local var_344_0 = {
			ja = 8.066,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_344_0:Play1106804084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1068ui_story"]) and arg_344_1.var_.characterEffect1068ui_story == nil then
				arg_344_1.var_.characterEffect1068ui_story = arg_344_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1068ui_story"]) then
				if arg_344_1.var_.characterEffect1068ui_story and not isNil(arg_344_1.actors_["1068ui_story"]) then
					arg_344_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1068ui_story"]) and arg_344_1.var_.characterEffect1068ui_story then
				arg_344_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068actionlink/1068action443")
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_347_2 = 0
			local var_347_3 = 0.2

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(1106804083)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 8 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 8)

				if (8 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 8)) > 0 and var_347_3 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804083", "story_v_side_new_1106804.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_side_new_1106804", "1106804083", "story_v_side_new_1106804.awb") / 1000

					if var_347_8 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_2
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_side_new_1106804", "1106804083", "story_v_side_new_1106804.awb")

						arg_344_1:RecordAudio("1106804083", var_347_9)
						arg_344_1:RecordAudio("1106804083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1106804", "1106804083", "story_v_side_new_1106804.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1106804", "1106804083", "story_v_side_new_1106804.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_10 and arg_344_1.time_ < var_347_2 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1106804084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1106804084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1106804085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1068ui_story"]) and arg_348_1.var_.characterEffect1068ui_story == nil then
				arg_348_1.var_.characterEffect1068ui_story = arg_348_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_0 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1068ui_story"]) then
				if arg_348_1.var_.characterEffect1068ui_story and not isNil(arg_348_1.actors_["1068ui_story"]) then
					arg_348_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_0)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1068ui_story"]) and arg_348_1.var_.characterEffect1068ui_story then
				arg_348_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_351_1 = 0
			local var_351_2 = 0.175

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(1106804084).content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 7 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 7)

				if (7 <= 0 and var_351_2 or var_351_2 * (utf8.len(var_351_3) / 7)) > 0 and var_351_2 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_6 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_6 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_6

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_6 and arg_348_1.time_ < var_351_1 + var_351_6 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1106804085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1106804085
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
			arg_352_1.auto_ = false
		end

		function arg_352_1.playNext_(arg_354_0)
			arg_352_1.onStoryFinished_()
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.825

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(1106804085).content)

				arg_352_1.text_.text = var_355_1

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_3 = 33 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 33)

				if (33 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_1) / 33)) > 0 and var_355_0 < var_355_3 then
					arg_352_1.talkMaxDuration = var_355_3

					if var_355_3 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_3 + 0
					end
				end

				arg_352_1.text_.text = var_355_1
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_4 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_4

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/F03c",
		"TextureConfig/Background/F03_2"
	},
	voices = {
		"story_v_side_new_1106804.awb"
	}
}
