return {
	Play1106103001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106103001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106103002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST29 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_4_0.name = "ST29"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST29 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST29

				arg_1_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST29" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.725

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1106103001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 29 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 29)

				if (29 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 29)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106103002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1106103002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1106103003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(1106103002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 4 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 4)

				if (4 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 4)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1106103003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1106103003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1106103004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(1106103003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 42)

				if (42 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 42)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1106103004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1106103004
		arg_16_1.duration_ = 2.43

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1106103005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1061ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1061ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1061ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1061ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1061ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1061ui_story = var_19_3.localPosition

				arg_16_1:ShowWeapon(arg_16_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1061ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1061ui_story == nil then
				arg_16_1.var_.characterEffect1061ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1061ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1061ui_story then
				arg_16_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.075

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(1106103004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 3 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 3)

				if (3 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 3)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")

						arg_16_1:RecordAudio("1106103004", var_19_15)
						arg_16_1:RecordAudio("1106103004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103004", "story_v_side_new_1106103.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1106103005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1106103005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1106103006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 2 < arg_20_1.time_ and arg_20_1.time_ <= 2 + arg_23_0 then
				local var_23_0 = arg_20_1.bgs_.ST29

				arg_20_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_1 = var_23_0:GetComponent("SpriteRenderer")

				if var_23_1 and var_23_1.sprite then
					local var_23_2 = 2 * (var_23_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_0.transform.localScale = Vector3.New(var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, var_23_2 / var_23_1.sprite.bounds.size.y < var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x and var_23_2 * manager.ui.mainCameraCom_.aspect / var_23_1.sprite.bounds.size.x or var_23_2 / var_23_1.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST29" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_3 = 4

			if 4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_3 + 0.3 and arg_20_1.time_ < var_23_3 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_4 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_5 = 2

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_5 then
				local var_23_6 = Color.New(0, 0, 0)

				var_23_6.a = Mathf.Lerp(0, 1, (arg_20_1.time_ - var_23_4) / var_23_5)
				arg_20_1.mask_.color = var_23_6
			end

			if arg_20_1.time_ >= var_23_4 + var_23_5 and arg_20_1.time_ < var_23_4 + var_23_5 + arg_23_0 then
				local var_23_7 = Color.New(0, 0, 0)

				var_23_7.a = 1
				arg_20_1.mask_.color = var_23_7
			end

			local var_23_8 = 2

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_9 = 2

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_9 then
				local var_23_10 = Color.New(0, 0, 0)

				var_23_10.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_8) / var_23_9)
				arg_20_1.mask_.color = var_23_10
			end

			if arg_20_1.time_ >= var_23_8 + var_23_9 and arg_20_1.time_ < var_23_8 + var_23_9 + arg_23_0 then
				local var_23_11 = Color.New(0, 0, 0)

				arg_20_1.mask_.enabled = false
				var_23_11.a = 0
				arg_20_1.mask_.color = var_23_11
			end

			local var_23_12 = arg_20_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_20_1.time_ and arg_20_1.time_ <= 1.96599999815226 + arg_23_0 then
				arg_20_1.var_.moveOldPos1061ui_story = var_23_12.localPosition
			end

			local var_23_13 = 0.001

			if 1.96599999815226 <= arg_20_1.time_ and arg_20_1.time_ < 1.96599999815226 + var_23_13 then
				var_23_12.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 1.96599999815226) / var_23_13)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			if arg_20_1.time_ >= 1.96599999815226 + var_23_13 and arg_20_1.time_ < 1.96599999815226 + var_23_13 + arg_23_0 then
				var_23_12.localPosition = Vector3.New(0, 100, 0)
				var_23_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_12.position).x, (manager.ui.mainCamera.transform.position - var_23_12.position).y, (manager.ui.mainCamera.transform.position - var_23_12.position).z)
				var_23_12.localEulerAngles.z = 0
				var_23_12.localEulerAngles.x = 0
				var_23_12.localEulerAngles = var_23_12.localEulerAngles
			end

			local var_23_14 = arg_20_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_20_1.time_ and arg_20_1.time_ <= 1.96599999815226 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1061ui_story == nil then
				arg_20_1.var_.characterEffect1061ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_15 = 0.034000001847744

			if 1.96599999815226 <= arg_20_1.time_ and arg_20_1.time_ < 1.96599999815226 + var_23_15 and not isNil(var_23_14) then
				if arg_20_1.var_.characterEffect1061ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 1.96599999815226) / var_23_15)
				end
			end

			if arg_20_1.time_ >= 1.96599999815226 + var_23_15 and arg_20_1.time_ < 1.96599999815226 + var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect1061ui_story then
				arg_20_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_16 = 4
			local var_23_17 = 1.2

			if 4 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_18 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_18:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1106103005).content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 48 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 48)

				if (48 <= 0 and var_23_17 or var_23_17 * (utf8.len(var_23_19) / 48)) > 0 and var_23_17 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21
					var_23_16 = var_23_16 + 0.3

					if var_23_21 + var_23_16 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_16
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = var_23_16 + 0.3
			local var_23_23 = math.max(var_23_17, arg_20_1.talkMaxDuration)

			if var_23_16 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_22 + var_23_23 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_22) / var_23_23

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_22 + var_23_23 and arg_20_1.time_ < var_23_22 + var_23_23 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play1106103006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 1106103006
		arg_26_1.duration_ = 1.2

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play1106103007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.125

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(1106103006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 5 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 5)

				if (5 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 5)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")

						arg_26_1:RecordAudio("1106103006", var_29_6)
						arg_26_1:RecordAudio("1106103006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103006", "story_v_side_new_1106103.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play1106103007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 1106103007
		arg_30_1.duration_ = 2.4

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play1106103008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1061ui_story = arg_30_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_33_0 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 then
				arg_30_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_30_1.time_ - 0) / var_33_0)
				arg_30_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).z)
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles = arg_30_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 then
				arg_30_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_30_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_30_1.actors_["1061ui_story"].transform.position).z)
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_30_1.actors_["1061ui_story"].transform.localEulerAngles = arg_30_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_33_1 = arg_30_1.actors_["1061ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1061ui_story == nil then
				arg_30_1.var_.characterEffect1061ui_story = var_33_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_2 and not isNil(var_33_1) then
				if arg_30_1.var_.characterEffect1061ui_story and not isNil(var_33_1) then
					arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_2 and arg_30_1.time_ < 0 + var_33_2 + arg_33_0 and not isNil(var_33_1) and arg_30_1.var_.characterEffect1061ui_story then
				arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_33_4 = 0
			local var_33_5 = 0.3

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(1106103007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 12 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 12)

				if (12 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 12)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")

						arg_30_1:RecordAudio("1106103007", var_33_11)
						arg_30_1:RecordAudio("1106103007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103007", "story_v_side_new_1106103.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play1106103008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 1106103008
		arg_34_1.duration_ = 4.57

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play1106103009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) and arg_34_1.var_.characterEffect1061ui_story == nil then
				arg_34_1.var_.characterEffect1061ui_story = arg_34_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) then
				if arg_34_1.var_.characterEffect1061ui_story and not isNil(arg_34_1.actors_["1061ui_story"]) then
					arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_0)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1061ui_story"]) and arg_34_1.var_.characterEffect1061ui_story then
				arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_37_1 = 0
			local var_37_2 = 0.625

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_3 = arg_34_1:GetWordFromCfg(1106103008)
				local var_37_4 = arg_34_1:FormatText(var_37_3.content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 25 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 25)

				if (25 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_4) / 25)) > 0 and var_37_2 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb") ~= 0 then
					local var_37_7 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb") / 1000

					if var_37_7 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_1
					end

					if var_37_3.prefab_name ~= "" and arg_34_1.actors_[var_37_3.prefab_name] ~= nil then
						local var_37_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_3.prefab_name].transform, "story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")

						arg_34_1:RecordAudio("1106103008", var_37_8)
						arg_34_1:RecordAudio("1106103008", var_37_8)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103008", "story_v_side_new_1106103.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_9 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_9 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_9

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_9 and arg_34_1.time_ < var_37_1 + var_37_9 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play1106103009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 1106103009
		arg_38_1.duration_ = 5.3

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play1106103010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.775

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:GetWordFromCfg(1106103009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 30 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 30)

				if (30 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 30)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")

						arg_38_1:RecordAudio("1106103009", var_41_6)
						arg_38_1:RecordAudio("1106103009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103009", "story_v_side_new_1106103.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play1106103010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 1106103010
		arg_42_1.duration_ = 9.4

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play1106103011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.225

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1353].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:GetWordFromCfg(1106103010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 49)

				if (49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 49)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")

						arg_42_1:RecordAudio("1106103010", var_45_6)
						arg_42_1:RecordAudio("1106103010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103010", "story_v_side_new_1106103.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play1106103011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 1106103011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play1106103012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1061ui_story = arg_46_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_49_0 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				arg_46_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).z)
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles = arg_46_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				arg_46_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["1061ui_story"].transform.position).z)
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["1061ui_story"].transform.localEulerAngles = arg_46_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_49_1 = 0
			local var_49_2 = 0.525

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(1106103011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 21 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 21)

				if (21 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 21)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play1106103012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 1106103012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play1106103013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.35

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(1106103012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 14 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 14)

				if (14 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 14)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play1106103013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1106103013
		arg_54_1.duration_ = 5.1

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1106103014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1061ui_story = arg_54_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_54_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1061ui_story"].transform.position).z)
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1061ui_story"].transform.localEulerAngles = arg_54_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1061ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1061ui_story == nil then
				arg_54_1.var_.characterEffect1061ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1061ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1061ui_story then
				arg_54_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_4 = 0
			local var_57_5 = 0.5

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(1106103013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 20 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 20)

				if (20 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 20)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")

						arg_54_1:RecordAudio("1106103013", var_57_11)
						arg_54_1:RecordAudio("1106103013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103013", "story_v_side_new_1106103.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play1106103014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1106103014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1106103015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) and arg_58_1.var_.characterEffect1061ui_story == nil then
				arg_58_1.var_.characterEffect1061ui_story = arg_58_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) then
				if arg_58_1.var_.characterEffect1061ui_story and not isNil(arg_58_1.actors_["1061ui_story"]) then
					arg_58_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1061ui_story"]) and arg_58_1.var_.characterEffect1061ui_story then
				arg_58_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(1106103014).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 20 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 20)

				if (20 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 20)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play1106103015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1106103015
		arg_62_1.duration_ = 9

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1106103016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.bgs_.ST47 == nil then
				local var_65_0 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_65_0.name = "ST47"
				var_65_0.transform.parent = arg_62_1.stage_.transform
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_.ST47 = var_65_0
			end

			if 2 < arg_62_1.time_ and arg_62_1.time_ <= 2 + arg_65_0 then
				local var_65_1 = arg_62_1.bgs_.ST47

				arg_62_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_65_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_2 = var_65_1:GetComponent("SpriteRenderer")

				if var_65_2 and var_65_2.sprite then
					local var_65_3 = 2 * (var_65_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_65_1.transform.localScale = Vector3.New(var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "ST47" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_4 = 4

			if 4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			if arg_62_1.time_ >= var_65_4 + 0.3 and arg_62_1.time_ < var_65_4 + 0.3 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			local var_65_5 = 0

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_6 = 2

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 then
				local var_65_7 = Color.New(0, 0, 0)

				var_65_7.a = Mathf.Lerp(0, 1, (arg_62_1.time_ - var_65_5) / var_65_6)
				arg_62_1.mask_.color = var_65_7
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 then
				local var_65_8 = Color.New(0, 0, 0)

				var_65_8.a = 1
				arg_62_1.mask_.color = var_65_8
			end

			local var_65_9 = 2

			if 2 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_10 = 2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 then
				local var_65_11 = Color.New(0, 0, 0)

				var_65_11.a = Mathf.Lerp(1, 0, (arg_62_1.time_ - var_65_9) / var_65_10)
				arg_62_1.mask_.color = var_65_11
			end

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 then
				local var_65_12 = Color.New(0, 0, 0)

				arg_62_1.mask_.enabled = false
				var_65_12.a = 0
				arg_62_1.mask_.color = var_65_12
			end

			local var_65_13 = arg_62_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_62_1.time_ and arg_62_1.time_ <= 1.96599999815226 + arg_65_0 then
				arg_62_1.var_.moveOldPos1061ui_story = var_65_13.localPosition
			end

			local var_65_14 = 0.001

			if 1.96599999815226 <= arg_62_1.time_ and arg_62_1.time_ < 1.96599999815226 + var_65_14 then
				var_65_13.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 1.96599999815226) / var_65_14)
				var_65_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_13.position).x, (manager.ui.mainCamera.transform.position - var_65_13.position).y, (manager.ui.mainCamera.transform.position - var_65_13.position).z)
				var_65_13.localEulerAngles.z = 0
				var_65_13.localEulerAngles.x = 0
				var_65_13.localEulerAngles = var_65_13.localEulerAngles
			end

			if arg_62_1.time_ >= 1.96599999815226 + var_65_14 and arg_62_1.time_ < 1.96599999815226 + var_65_14 + arg_65_0 then
				var_65_13.localPosition = Vector3.New(0, 100, 0)
				var_65_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_13.position).x, (manager.ui.mainCamera.transform.position - var_65_13.position).y, (manager.ui.mainCamera.transform.position - var_65_13.position).z)
				var_65_13.localEulerAngles.z = 0
				var_65_13.localEulerAngles.x = 0
				var_65_13.localEulerAngles = var_65_13.localEulerAngles
			end

			if 1.53333333333333 < arg_62_1.time_ and arg_62_1.time_ <= 1.53333333333333 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_65_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_18 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_18

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_18
						arg_62_1.bgmTxt2_.text = var_65_18
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.6 < arg_62_1.time_ and arg_62_1.time_ <= 0.6 + arg_65_0 then
				arg_62_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_65_21 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_62_1.bgmTxt_.text ~= var_65_21 and arg_62_1.bgmTxt_.text ~= "" then
						if arg_62_1.bgmTxt2_.text ~= "" then
							arg_62_1.bgmTxt_.text = arg_62_1.bgmTxt2_.text
						end

						arg_62_1.bgmTxt2_.text = var_65_21

						arg_62_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_62_1.bgmTxt_.text = var_65_21
						arg_62_1.bgmTxt2_.text = var_65_21
					end

					if arg_62_1.bgmTimer then
						arg_62_1.bgmTimer:Stop()

						arg_62_1.bgmTimer = nil
					end

					if arg_62_1.settingData.show_music_name == 1 then
						arg_62_1.musicController:SetSelectedState("show")
						arg_62_1.musicAnimator_:Play("open", 0, 0)

						if arg_62_1.settingData.music_time ~= 0 then
							arg_62_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_62_1.settingData.music_time), function()
								if arg_62_1 == nil or isNil(arg_62_1.bgmTxt_) then
									return
								end

								arg_62_1.musicController:SetSelectedState("hide")
								arg_62_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.0666666666666667 < arg_62_1.time_ and arg_62_1.time_ <= 0.0666666666666667 + arg_65_0 then
				arg_62_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_23 = 4
			local var_65_24 = 1.35

			if 4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_23 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_25 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_25:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_62_1.dialogCg_.alpha = arg_68_0
				end))
				var_65_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_26 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(1106103015).content)

				arg_62_1.text_.text = var_65_26

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_28 = 54 <= 0 and var_65_24 or var_65_24 * (utf8.len(var_65_26) / 54)

				if (54 <= 0 and var_65_24 or var_65_24 * (utf8.len(var_65_26) / 54)) > 0 and var_65_24 < var_65_28 then
					arg_62_1.talkMaxDuration = var_65_28
					var_65_23 = var_65_23 + 0.3

					if var_65_28 + var_65_23 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_28 + var_65_23
					end
				end

				arg_62_1.text_.text = var_65_26
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_29 = var_65_23 + 0.3
			local var_65_30 = math.max(var_65_24, arg_62_1.talkMaxDuration)

			if var_65_23 + 0.3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_29 + var_65_30 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_29) / var_65_30

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_29 + var_65_30 and arg_62_1.time_ < var_65_29 + var_65_30 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play1106103016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1106103016
		arg_70_1.duration_ = 5.47

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1106103017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.625

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(1106103016)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 25 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 25)

				if (25 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 25)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")

						arg_70_1:RecordAudio("1106103016", var_73_6)
						arg_70_1:RecordAudio("1106103016", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103016", "story_v_side_new_1106103.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1106103017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1106103017
		arg_74_1.duration_ = 1.9

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1106103018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.175

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1356].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(1106103017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 7 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 7)

				if (7 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 7)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")

						arg_74_1:RecordAudio("1106103017", var_77_6)
						arg_74_1:RecordAudio("1106103017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103017", "story_v_side_new_1106103.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1106103018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1106103018
		arg_78_1.duration_ = 4.77

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1106103019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.6

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(1106103018)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 24 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 24)

				if (24 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 24)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")

						arg_78_1:RecordAudio("1106103018", var_81_6)
						arg_78_1:RecordAudio("1106103018", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103018", "story_v_side_new_1106103.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1106103019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1106103019
		arg_82_1.duration_ = 3.1

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1106103020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.375

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1355].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwa")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:GetWordFromCfg(1106103019)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 15 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 15)

				if (15 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 15)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")

						arg_82_1:RecordAudio("1106103019", var_85_6)
						arg_82_1:RecordAudio("1106103019", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103019", "story_v_side_new_1106103.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1106103020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1106103020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1106103021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.8

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(1106103020).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 32 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 32)

				if (32 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 32)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1106103021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1106103021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1106103022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.625

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(1106103021).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 25)

				if (25 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 25)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1106103022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1106103022
		arg_94_1.duration_ = 4.6

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1106103023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1061ui_story = arg_94_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).z)
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles = arg_94_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_94_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1061ui_story"].transform.position).z)
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1061ui_story"].transform.localEulerAngles = arg_94_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["1061ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1061ui_story == nil then
				arg_94_1.var_.characterEffect1061ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 and not isNil(var_97_1) then
				if arg_94_1.var_.characterEffect1061ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1061ui_story then
				arg_94_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_4 = 0
			local var_97_5 = 0.6

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(1106103022)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 24 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 24)

				if (24 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 24)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")

						arg_94_1:RecordAudio("1106103022", var_97_11)
						arg_94_1:RecordAudio("1106103022", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103022", "story_v_side_new_1106103.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play1106103023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1106103023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1106103024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1061ui_story"]) and arg_98_1.var_.characterEffect1061ui_story == nil then
				arg_98_1.var_.characterEffect1061ui_story = arg_98_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1061ui_story"]) then
				if arg_98_1.var_.characterEffect1061ui_story and not isNil(arg_98_1.actors_["1061ui_story"]) then
					arg_98_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1061ui_story"]) and arg_98_1.var_.characterEffect1061ui_story then
				arg_98_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.425

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(1106103023).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 17 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 17)

				if (17 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 17)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1106103024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1106103024
		arg_102_1.duration_ = 2.97

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1106103025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1061ui_story = arg_102_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_102_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1061ui_story"].transform.position).z)
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1061ui_story"].transform.localEulerAngles = arg_102_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1061ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect1061ui_story then
				arg_102_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_2")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_4 = 0
			local var_105_5 = 0.3

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(1106103024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 12 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 12)

				if (12 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 12)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")

						arg_102_1:RecordAudio("1106103024", var_105_11)
						arg_102_1:RecordAudio("1106103024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103024", "story_v_side_new_1106103.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play1106103025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1106103025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1106103026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1061ui_story = arg_106_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).z)
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles = arg_106_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1061ui_story"].transform.position).z)
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1061ui_story"].transform.localEulerAngles = arg_106_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1061ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_2)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_109_3 = 0
			local var_109_4 = 0.725

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_5 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(1106103025).content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 29 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_5) / 29)

				if (29 <= 0 and var_109_4 or var_109_4 * (utf8.len(var_109_5) / 29)) > 0 and var_109_4 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_3 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_3
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_8 = math.max(var_109_4, arg_106_1.talkMaxDuration)

			if var_109_3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_3 + var_109_8 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_3) / var_109_8

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_3 + var_109_8 and arg_106_1.time_ < var_109_3 + var_109_8 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play1106103026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1106103026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1106103027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.925

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1106103026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 37 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 37)

				if (37 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 37)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1106103027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1106103027
		arg_114_1.duration_ = 1.27

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1106103028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1061ui_story = arg_114_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).z)
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles = arg_114_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_114_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1061ui_story"].transform.position).z)
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1061ui_story"].transform.localEulerAngles = arg_114_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["1061ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_4 = 0
			local var_117_5 = 0.125

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(1106103027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 5 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 5)

				if (5 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 5)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")

						arg_114_1:RecordAudio("1106103027", var_117_11)
						arg_114_1:RecordAudio("1106103027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103027", "story_v_side_new_1106103.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play1106103028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1106103028
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1106103029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = arg_118_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) then
				if arg_118_1.var_.characterEffect1061ui_story and not isNil(arg_118_1.actors_["1061ui_story"]) then
					arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1061ui_story"]) and arg_118_1.var_.characterEffect1061ui_story then
				arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.425

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1106103028).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 17 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 17)

				if (17 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 17)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1106103029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1106103029
		arg_122_1.duration_ = 3.23

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1106103030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1061ui_story = arg_122_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).z)
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles = arg_122_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_122_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1061ui_story"].transform.position).z)
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1061ui_story"].transform.localEulerAngles = arg_122_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["1061ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1061ui_story == nil then
				arg_122_1.var_.characterEffect1061ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1061ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1061ui_story then
				arg_122_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_125_4 = 0
			local var_125_5 = 0.4

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(1106103029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 16 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 16)

				if (16 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 16)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")

						arg_122_1:RecordAudio("1106103029", var_125_11)
						arg_122_1:RecordAudio("1106103029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103029", "story_v_side_new_1106103.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play1106103030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1106103030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1106103031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = arg_126_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_129_1 = arg_126_1.actors_["1061ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 and not isNil(var_129_1) then
				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_1) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_2)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 and not isNil(var_129_1) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_129_3 = 0
			local var_129_4 = 1.15

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_5 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1106103030).content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_7 = 46 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_5) / 46)

				if (46 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_5) / 46)) > 0 and var_129_4 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_3
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_4, arg_126_1.talkMaxDuration)

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_3) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_3 + var_129_8 and arg_126_1.time_ < var_129_3 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play1106103031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1106103031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1106103032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.525

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(1106103031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 21)

				if (21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 21)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1106103032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1106103032
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1106103033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1061ui_story = arg_134_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).z)
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles = arg_134_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_134_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1061ui_story"].transform.position).z)
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1061ui_story"].transform.localEulerAngles = arg_134_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1061ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_4 = 0
			local var_137_5 = 0.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(1106103032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)

				if (6 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 6)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")

						arg_134_1:RecordAudio("1106103032", var_137_11)
						arg_134_1:RecordAudio("1106103032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103032", "story_v_side_new_1106103.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play1106103033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1106103033
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1106103034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = arg_138_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) then
				if arg_138_1.var_.characterEffect1061ui_story and not isNil(arg_138_1.actors_["1061ui_story"]) then
					arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1061ui_story"]) and arg_138_1.var_.characterEffect1061ui_story then
				arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.125

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(1106103033).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 5 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 5)

				if (5 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 5)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1106103034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1106103034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1106103035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.875

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(1106103034).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 35 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 35)

				if (35 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 35)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1106103035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1106103035
		arg_146_1.duration_ = 3.53

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1106103036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1061ui_story = arg_146_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).z)
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles = arg_146_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_146_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1061ui_story"].transform.position).z)
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1061ui_story"].transform.localEulerAngles = arg_146_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1061ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1061ui_story == nil then
				arg_146_1.var_.characterEffect1061ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1061ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1061ui_story then
				arg_146_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_149_4 = 0
			local var_149_5 = 0.425

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(1106103035)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 17 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 17)

				if (17 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 17)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")

						arg_146_1:RecordAudio("1106103035", var_149_11)
						arg_146_1:RecordAudio("1106103035", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103035", "story_v_side_new_1106103.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play1106103036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1106103036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1106103037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1061ui_story"]) and arg_150_1.var_.characterEffect1061ui_story == nil then
				arg_150_1.var_.characterEffect1061ui_story = arg_150_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1061ui_story"]) then
				if arg_150_1.var_.characterEffect1061ui_story and not isNil(arg_150_1.actors_["1061ui_story"]) then
					arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1061ui_story"]) and arg_150_1.var_.characterEffect1061ui_story then
				arg_150_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 0.5

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1106103036).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)

				if (20 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 20)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1106103037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1106103037
		arg_154_1.duration_ = 2.9

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1106103038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1061ui_story = arg_154_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).z)
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles = arg_154_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_154_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1061ui_story"].transform.position).z)
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1061ui_story"].transform.localEulerAngles = arg_154_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1061ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = var_157_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 and not isNil(var_157_1) then
				if arg_154_1.var_.characterEffect1061ui_story and not isNil(var_157_1) then
					arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1061ui_story then
				arg_154_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action452")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_4 = 0
			local var_157_5 = 0.3

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(1106103037)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 12 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 12)

				if (12 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 12)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")

						arg_154_1:RecordAudio("1106103037", var_157_11)
						arg_154_1:RecordAudio("1106103037", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103037", "story_v_side_new_1106103.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play1106103038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1106103038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1106103039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1061ui_story"]) and arg_158_1.var_.characterEffect1061ui_story == nil then
				arg_158_1.var_.characterEffect1061ui_story = arg_158_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1061ui_story"]) then
				if arg_158_1.var_.characterEffect1061ui_story and not isNil(arg_158_1.actors_["1061ui_story"]) then
					arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1061ui_story"]) and arg_158_1.var_.characterEffect1061ui_story then
				arg_158_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.375

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(1106103038).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 15 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 15)

				if (15 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 15)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1106103039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1106103039
		arg_162_1.duration_ = 2.67

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1106103040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1061ui_story = arg_162_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).z)
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles = arg_162_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_162_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1061ui_story"].transform.position).z)
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1061ui_story"].transform.localEulerAngles = arg_162_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["1061ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 and not isNil(var_165_1) then
				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_1) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 and not isNil(var_165_1) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_165_4 = 0
			local var_165_5 = 0.3

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_6 = arg_162_1:GetWordFromCfg(1106103039)
				local var_165_7 = arg_162_1:FormatText(var_165_6.content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 12 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 12)

				if (12 <= 0 and var_165_5 or var_165_5 * (utf8.len(var_165_7) / 12)) > 0 and var_165_5 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_4
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb") ~= 0 then
					local var_165_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb") / 1000

					if var_165_10 + var_165_4 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_10 + var_165_4
					end

					if var_165_6.prefab_name ~= "" and arg_162_1.actors_[var_165_6.prefab_name] ~= nil then
						local var_165_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_6.prefab_name].transform, "story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")

						arg_162_1:RecordAudio("1106103039", var_165_11)
						arg_162_1:RecordAudio("1106103039", var_165_11)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103039", "story_v_side_new_1106103.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_12 = math.max(var_165_5, arg_162_1.talkMaxDuration)

			if var_165_4 <= arg_162_1.time_ and arg_162_1.time_ < var_165_4 + var_165_12 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_4) / var_165_12

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_4 + var_165_12 and arg_162_1.time_ < var_165_4 + var_165_12 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play1106103040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1106103040
		arg_166_1.duration_ = 9

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1106103041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 then
				local var_169_0 = arg_166_1.bgs_.ST29

				arg_166_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_1 = var_169_0:GetComponent("SpriteRenderer")

				if var_169_1 and var_169_1.sprite then
					local var_169_2 = 2 * (var_169_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_0.transform.localScale = Vector3.New(var_169_2 / var_169_1.sprite.bounds.size.y < var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x and var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x or var_169_2 / var_169_1.sprite.bounds.size.y, var_169_2 / var_169_1.sprite.bounds.size.y < var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x and var_169_2 * manager.ui.mainCameraCom_.aspect / var_169_1.sprite.bounds.size.x or var_169_2 / var_169_1.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST29" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_3 = 4

			if 4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_3 + 0.3 and arg_166_1.time_ < var_169_3 + 0.3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_4 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_5 = 2

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_5 then
				local var_169_6 = Color.New(0, 0, 0)

				var_169_6.a = Mathf.Lerp(0, 1, (arg_166_1.time_ - var_169_4) / var_169_5)
				arg_166_1.mask_.color = var_169_6
			end

			if arg_166_1.time_ >= var_169_4 + var_169_5 and arg_166_1.time_ < var_169_4 + var_169_5 + arg_169_0 then
				local var_169_7 = Color.New(0, 0, 0)

				var_169_7.a = 1
				arg_166_1.mask_.color = var_169_7
			end

			local var_169_8 = 2

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_9 = 2

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_9 then
				local var_169_10 = Color.New(0, 0, 0)

				var_169_10.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_8) / var_169_9)
				arg_166_1.mask_.color = var_169_10
			end

			if arg_166_1.time_ >= var_169_8 + var_169_9 and arg_166_1.time_ < var_169_8 + var_169_9 + arg_169_0 then
				local var_169_11 = Color.New(0, 0, 0)

				arg_166_1.mask_.enabled = false
				var_169_11.a = 0
				arg_166_1.mask_.color = var_169_11
			end

			local var_169_12 = arg_166_1.actors_["1061ui_story"].transform

			if 1.96599999815226 < arg_166_1.time_ and arg_166_1.time_ <= 1.96599999815226 + arg_169_0 then
				arg_166_1.var_.moveOldPos1061ui_story = var_169_12.localPosition
			end

			local var_169_13 = 0.001

			if 1.96599999815226 <= arg_166_1.time_ and arg_166_1.time_ < 1.96599999815226 + var_169_13 then
				var_169_12.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 1.96599999815226) / var_169_13)
				var_169_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_12.position).x, (manager.ui.mainCamera.transform.position - var_169_12.position).y, (manager.ui.mainCamera.transform.position - var_169_12.position).z)
				var_169_12.localEulerAngles.z = 0
				var_169_12.localEulerAngles.x = 0
				var_169_12.localEulerAngles = var_169_12.localEulerAngles
			end

			if arg_166_1.time_ >= 1.96599999815226 + var_169_13 and arg_166_1.time_ < 1.96599999815226 + var_169_13 + arg_169_0 then
				var_169_12.localPosition = Vector3.New(0, 100, 0)
				var_169_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_12.position).x, (manager.ui.mainCamera.transform.position - var_169_12.position).y, (manager.ui.mainCamera.transform.position - var_169_12.position).z)
				var_169_12.localEulerAngles.z = 0
				var_169_12.localEulerAngles.x = 0
				var_169_12.localEulerAngles = var_169_12.localEulerAngles
			end

			local var_169_14 = arg_166_1.actors_["1061ui_story"]

			if 1.96599999815226 < arg_166_1.time_ and arg_166_1.time_ <= 1.96599999815226 + arg_169_0 and not isNil(var_169_14) and arg_166_1.var_.characterEffect1061ui_story == nil then
				arg_166_1.var_.characterEffect1061ui_story = var_169_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_15 = 0.034000001847744

			if 1.96599999815226 <= arg_166_1.time_ and arg_166_1.time_ < 1.96599999815226 + var_169_15 and not isNil(var_169_14) then
				if arg_166_1.var_.characterEffect1061ui_story and not isNil(var_169_14) then
					arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 1.96599999815226) / var_169_15)
				end
			end

			if arg_166_1.time_ >= 1.96599999815226 + var_169_15 and arg_166_1.time_ < 1.96599999815226 + var_169_15 + arg_169_0 and not isNil(var_169_14) and arg_166_1.var_.characterEffect1061ui_story then
				arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 1.53333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 1.53333333333333 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0.0666666666666667 < arg_166_1.time_ and arg_166_1.time_ <= 0.0666666666666667 + arg_169_0 then
				arg_166_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_18 = 4
			local var_169_19 = 0.475

			if 4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_20 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_20:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_21 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(1106103040).content)

				arg_166_1.text_.text = var_169_21

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 19 <= 0 and var_169_19 or var_169_19 * (utf8.len(var_169_21) / 19)

				if (19 <= 0 and var_169_19 or var_169_19 * (utf8.len(var_169_21) / 19)) > 0 and var_169_19 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23
					var_169_18 = var_169_18 + 0.3

					if var_169_23 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_18
					end
				end

				arg_166_1.text_.text = var_169_21
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_24 = var_169_18 + 0.3
			local var_169_25 = math.max(var_169_19, arg_166_1.talkMaxDuration)

			if var_169_18 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_24 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_24) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_24 + var_169_25 and arg_166_1.time_ < var_169_24 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play1106103041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1106103041
		arg_172_1.duration_ = 5.77

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1106103042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.65

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(1106103041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 26 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 26)

				if (26 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 26)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")

						arg_172_1:RecordAudio("1106103041", var_175_6)
						arg_172_1:RecordAudio("1106103041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103041", "story_v_side_new_1106103.awb")
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
	Play1106103042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1106103042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1106103043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.525

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(1106103042).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 21 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 21)

				if (21 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 21)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1106103043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1106103043
		arg_180_1.duration_ = 1.77

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1106103044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1061ui_story = arg_180_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).z)
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles = arg_180_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_180_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1061ui_story"].transform.position).z)
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1061ui_story"].transform.localEulerAngles = arg_180_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1061ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1061ui_story == nil then
				arg_180_1.var_.characterEffect1061ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1061ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1061ui_story then
				arg_180_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_183_4 = 0
			local var_183_5 = 0.225

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_6 = arg_180_1:GetWordFromCfg(1106103043)
				local var_183_7 = arg_180_1:FormatText(var_183_6.content)

				arg_180_1.text_.text = var_183_7

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 9 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 9)

				if (9 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 9)) > 0 and var_183_5 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_7
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb") / 1000

					if var_183_10 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_4
					end

					if var_183_6.prefab_name ~= "" and arg_180_1.actors_[var_183_6.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_6.prefab_name].transform, "story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")

						arg_180_1:RecordAudio("1106103043", var_183_11)
						arg_180_1:RecordAudio("1106103043", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103043", "story_v_side_new_1106103.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_5, arg_180_1.talkMaxDuration)

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_4) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_4 + var_183_12 and arg_180_1.time_ < var_183_4 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play1106103044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1106103044
		arg_184_1.duration_ = 4.87

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1106103045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_187_0 = 0
			local var_187_1 = 0.55

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_2 = arg_184_1:GetWordFromCfg(1106103044)
				local var_187_3 = arg_184_1:FormatText(var_187_2.content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 22 <= 0 and var_187_1 or var_187_1 * (utf8.len(var_187_3) / 22)

				if (22 <= 0 and var_187_1 or var_187_1 * (utf8.len(var_187_3) / 22)) > 0 and var_187_1 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb") ~= 0 then
					local var_187_6 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb") / 1000

					if var_187_6 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_0
					end

					if var_187_2.prefab_name ~= "" and arg_184_1.actors_[var_187_2.prefab_name] ~= nil then
						local var_187_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_2.prefab_name].transform, "story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")

						arg_184_1:RecordAudio("1106103044", var_187_7)
						arg_184_1:RecordAudio("1106103044", var_187_7)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103044", "story_v_side_new_1106103.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_8 and arg_184_1.time_ < var_187_0 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1106103045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1106103045
		arg_188_1.duration_ = 1

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"

			SetActive(arg_188_1.choicesGo_, true)

			for iter_189_0, iter_189_1 in ipairs(arg_188_1.choices_) do
				SetActive(iter_189_1.go, iter_189_0 <= 2)
			end

			arg_188_1.choices_[1].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1392].name)
			arg_188_1.choices_[2].txt.text = arg_188_1:FormatText(StoryChoiceCfg[1393].name)
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1106103046(arg_188_1)
			end

			if arg_190_0 == 2 then
				arg_188_0:Play1106103046(arg_188_1)
			end

			arg_188_1:RecordChoiceLog(1106103045, 1392, 1393)
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1061ui_story"]) and arg_188_1.var_.characterEffect1061ui_story == nil then
				arg_188_1.var_.characterEffect1061ui_story = arg_188_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1061ui_story"]) then
				if arg_188_1.var_.characterEffect1061ui_story and not isNil(arg_188_1.actors_["1061ui_story"]) then
					arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1061ui_story"]) and arg_188_1.var_.characterEffect1061ui_story then
				arg_188_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= var_191_1 + 0.6 and arg_188_1.time_ < var_191_1 + 0.6 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1106103046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1106103046
		arg_192_1.duration_ = 4.77

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1106103047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) and arg_192_1.var_.characterEffect1061ui_story == nil then
				arg_192_1.var_.characterEffect1061ui_story = arg_192_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) then
				if arg_192_1.var_.characterEffect1061ui_story and not isNil(arg_192_1.actors_["1061ui_story"]) then
					arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1061ui_story"]) and arg_192_1.var_.characterEffect1061ui_story then
				arg_192_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_195_2 = "1061ui_story"

			if arg_192_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_195_3 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_192_1.stage_.transform)

				var_195_3.name = var_195_2
				var_195_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_[var_195_2] = var_195_3

				local var_195_4 = var_195_3:GetComponentInChildren(typeof(CharacterEffect))

				var_195_4.enabled = true

				local var_195_5 = GameObjectTools.GetOrAddComponent(var_195_3, typeof(DynamicBoneHelper))

				if var_195_5 then
					var_195_5:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_4.transform, false)

				arg_192_1.var_[var_195_2 .. "Animator"] = var_195_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_[var_195_2 .. "Animator"].applyRootMotion = true
				arg_192_1.var_[var_195_2 .. "LipSync"] = var_195_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action432")
			end

			local var_195_6 = "1061ui_story"

			if arg_192_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_195_7 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_192_1.stage_.transform)

				var_195_7.name = var_195_6
				var_195_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_[var_195_6] = var_195_7

				local var_195_8 = var_195_7:GetComponentInChildren(typeof(CharacterEffect))

				var_195_8.enabled = true

				local var_195_9 = GameObjectTools.GetOrAddComponent(var_195_7, typeof(DynamicBoneHelper))

				if var_195_9 then
					var_195_9:EnableDynamicBone(false)
				end

				arg_192_1:ShowWeapon(var_195_8.transform, false)

				arg_192_1.var_[var_195_6 .. "Animator"] = var_195_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_192_1.var_[var_195_6 .. "Animator"].applyRootMotion = true
				arg_192_1.var_[var_195_6 .. "LipSync"] = var_195_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_195_10 = 0
			local var_195_11 = 0.425

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_12 = arg_192_1:GetWordFromCfg(1106103046)
				local var_195_13 = arg_192_1:FormatText(var_195_12.content)

				arg_192_1.text_.text = var_195_13

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 17 <= 0 and var_195_11 or var_195_11 * (utf8.len(var_195_13) / 17)

				if (17 <= 0 and var_195_11 or var_195_11 * (utf8.len(var_195_13) / 17)) > 0 and var_195_11 < var_195_15 then
					arg_192_1.talkMaxDuration = var_195_15

					if var_195_15 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_15 + var_195_10
					end
				end

				arg_192_1.text_.text = var_195_13
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb") ~= 0 then
					local var_195_16 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb") / 1000

					if var_195_16 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_16 + var_195_10
					end

					if var_195_12.prefab_name ~= "" and arg_192_1.actors_[var_195_12.prefab_name] ~= nil then
						local var_195_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_12.prefab_name].transform, "story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")

						arg_192_1:RecordAudio("1106103046", var_195_17)
						arg_192_1:RecordAudio("1106103046", var_195_17)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103046", "story_v_side_new_1106103.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_18 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_18 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_10) / var_195_18

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_10 + var_195_18 and arg_192_1.time_ < var_195_10 + var_195_18 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1106103047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1106103047
		arg_196_1.duration_ = 7.3

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1106103048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.775

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:GetWordFromCfg(1106103047)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 31 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 31)

				if (31 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 31)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")

						arg_196_1:RecordAudio("1106103047", var_199_6)
						arg_196_1:RecordAudio("1106103047", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103047", "story_v_side_new_1106103.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1106103048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1106103048
		arg_200_1.duration_ = 1

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"

			SetActive(arg_200_1.choicesGo_, true)

			for iter_201_0, iter_201_1 in ipairs(arg_200_1.choices_) do
				SetActive(iter_201_1.go, iter_201_0 <= 2)
			end

			arg_200_1.choices_[1].txt.text = arg_200_1:FormatText(StoryChoiceCfg[1393].name)
			arg_200_1.choices_[2].txt.text = arg_200_1:FormatText(StoryChoiceCfg[1392].name)
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1106103049(arg_200_1)
			end

			if arg_202_0 == 2 then
				arg_200_0:Play1106103049(arg_200_1)
			end

			arg_200_1:RecordChoiceLog(1106103048, 1393, 1392)
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) and arg_200_1.var_.characterEffect1061ui_story == nil then
				arg_200_1.var_.characterEffect1061ui_story = arg_200_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) then
				if arg_200_1.var_.characterEffect1061ui_story and not isNil(arg_200_1.actors_["1061ui_story"]) then
					arg_200_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1061ui_story"]) and arg_200_1.var_.characterEffect1061ui_story then
				arg_200_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_1 + 0.6 and arg_200_1.time_ < var_203_1 + 0.6 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1106103049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1106103049
		arg_204_1.duration_ = 3.2

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1106103050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1061ui_story"]) and arg_204_1.var_.characterEffect1061ui_story == nil then
				arg_204_1.var_.characterEffect1061ui_story = arg_204_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1061ui_story"]) then
				if arg_204_1.var_.characterEffect1061ui_story and not isNil(arg_204_1.actors_["1061ui_story"]) then
					arg_204_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1061ui_story"]) and arg_204_1.var_.characterEffect1061ui_story then
				arg_204_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_207_2 = "1061ui_story"

			if arg_204_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_207_3 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_204_1.stage_.transform)

				var_207_3.name = var_207_2
				var_207_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_[var_207_2] = var_207_3

				local var_207_4 = var_207_3:GetComponentInChildren(typeof(CharacterEffect))

				var_207_4.enabled = true

				local var_207_5 = GameObjectTools.GetOrAddComponent(var_207_3, typeof(DynamicBoneHelper))

				if var_207_5 then
					var_207_5:EnableDynamicBone(false)
				end

				arg_204_1:ShowWeapon(var_207_4.transform, false)

				arg_204_1.var_[var_207_2 .. "Animator"] = var_207_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_204_1.var_[var_207_2 .. "Animator"].applyRootMotion = true
				arg_204_1.var_[var_207_2 .. "LipSync"] = var_207_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action428")
			end

			local var_207_6 = "1061ui_story"

			if arg_204_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_207_7 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_204_1.stage_.transform)

				var_207_7.name = var_207_6
				var_207_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_[var_207_6] = var_207_7

				local var_207_8 = var_207_7:GetComponentInChildren(typeof(CharacterEffect))

				var_207_8.enabled = true

				local var_207_9 = GameObjectTools.GetOrAddComponent(var_207_7, typeof(DynamicBoneHelper))

				if var_207_9 then
					var_207_9:EnableDynamicBone(false)
				end

				arg_204_1:ShowWeapon(var_207_8.transform, false)

				arg_204_1.var_[var_207_6 .. "Animator"] = var_207_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_204_1.var_[var_207_6 .. "Animator"].applyRootMotion = true
				arg_204_1.var_[var_207_6 .. "LipSync"] = var_207_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_10 = 0
			local var_207_11 = 0.325

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_10 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_12 = arg_204_1:GetWordFromCfg(1106103049)
				local var_207_13 = arg_204_1:FormatText(var_207_12.content)

				arg_204_1.text_.text = var_207_13

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_15 = 13 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 13)

				if (13 <= 0 and var_207_11 or var_207_11 * (utf8.len(var_207_13) / 13)) > 0 and var_207_11 < var_207_15 then
					arg_204_1.talkMaxDuration = var_207_15

					if var_207_15 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_15 + var_207_10
					end
				end

				arg_204_1.text_.text = var_207_13
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb") ~= 0 then
					local var_207_16 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb") / 1000

					if var_207_16 + var_207_10 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_16 + var_207_10
					end

					if var_207_12.prefab_name ~= "" and arg_204_1.actors_[var_207_12.prefab_name] ~= nil then
						local var_207_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_12.prefab_name].transform, "story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")

						arg_204_1:RecordAudio("1106103049", var_207_17)
						arg_204_1:RecordAudio("1106103049", var_207_17)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103049", "story_v_side_new_1106103.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_18 = math.max(var_207_11, arg_204_1.talkMaxDuration)

			if var_207_10 <= arg_204_1.time_ and arg_204_1.time_ < var_207_10 + var_207_18 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_10) / var_207_18

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_10 + var_207_18 and arg_204_1.time_ < var_207_10 + var_207_18 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1106103050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1106103050
		arg_208_1.duration_ = 1.87

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1106103051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.225

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(1106103050)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 9 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 9)

				if (9 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 9)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")

						arg_208_1:RecordAudio("1106103050", var_211_6)
						arg_208_1:RecordAudio("1106103050", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103050", "story_v_side_new_1106103.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1106103051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1106103051
		arg_212_1.duration_ = 1

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"

			SetActive(arg_212_1.choicesGo_, true)

			for iter_213_0, iter_213_1 in ipairs(arg_212_1.choices_) do
				SetActive(iter_213_1.go, iter_213_0 <= 2)
			end

			arg_212_1.choices_[1].txt.text = arg_212_1:FormatText(StoryChoiceCfg[1392].name)
			arg_212_1.choices_[2].txt.text = arg_212_1:FormatText(StoryChoiceCfg[1393].name)
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1106103052(arg_212_1)
			end

			if arg_214_0 == 2 then
				arg_212_0:Play1106103052(arg_212_1)
			end

			arg_212_1:RecordChoiceLog(1106103051, 1392, 1393)
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1061ui_story"]) and arg_212_1.var_.characterEffect1061ui_story == nil then
				arg_212_1.var_.characterEffect1061ui_story = arg_212_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1061ui_story"]) then
				if arg_212_1.var_.characterEffect1061ui_story and not isNil(arg_212_1.actors_["1061ui_story"]) then
					arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_0)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1061ui_story"]) and arg_212_1.var_.characterEffect1061ui_story then
				arg_212_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_215_1 = 0

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.allBtn_.enabled = false
			end

			if arg_212_1.time_ >= var_215_1 + 0.6 and arg_212_1.time_ < var_215_1 + 0.6 + arg_215_0 then
				arg_212_1.allBtn_.enabled = true
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1106103052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1106103052
		arg_216_1.duration_ = 2

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1106103053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1061ui_story"]) and arg_216_1.var_.characterEffect1061ui_story == nil then
				arg_216_1.var_.characterEffect1061ui_story = arg_216_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1061ui_story"]) then
				if arg_216_1.var_.characterEffect1061ui_story and not isNil(arg_216_1.actors_["1061ui_story"]) then
					arg_216_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1061ui_story"]) and arg_216_1.var_.characterEffect1061ui_story then
				arg_216_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_219_2 = "1061ui_story"

			if arg_216_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_219_3 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_216_1.stage_.transform)

				var_219_3.name = var_219_2
				var_219_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_[var_219_2] = var_219_3

				local var_219_4 = var_219_3:GetComponentInChildren(typeof(CharacterEffect))

				var_219_4.enabled = true

				local var_219_5 = GameObjectTools.GetOrAddComponent(var_219_3, typeof(DynamicBoneHelper))

				if var_219_5 then
					var_219_5:EnableDynamicBone(false)
				end

				arg_216_1:ShowWeapon(var_219_4.transform, false)

				arg_216_1.var_[var_219_2 .. "Animator"] = var_219_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_216_1.var_[var_219_2 .. "Animator"].applyRootMotion = true
				arg_216_1.var_[var_219_2 .. "LipSync"] = var_219_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action485")
			end

			local var_219_6 = "1061ui_story"

			if arg_216_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_219_7 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_216_1.stage_.transform)

				var_219_7.name = var_219_6
				var_219_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_[var_219_6] = var_219_7

				local var_219_8 = var_219_7:GetComponentInChildren(typeof(CharacterEffect))

				var_219_8.enabled = true

				local var_219_9 = GameObjectTools.GetOrAddComponent(var_219_7, typeof(DynamicBoneHelper))

				if var_219_9 then
					var_219_9:EnableDynamicBone(false)
				end

				arg_216_1:ShowWeapon(var_219_8.transform, false)

				arg_216_1.var_[var_219_6 .. "Animator"] = var_219_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_216_1.var_[var_219_6 .. "Animator"].applyRootMotion = true
				arg_216_1.var_[var_219_6 .. "LipSync"] = var_219_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_219_10 = 0
			local var_219_11 = 0.2

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_12 = arg_216_1:GetWordFromCfg(1106103052)
				local var_219_13 = arg_216_1:FormatText(var_219_12.content)

				arg_216_1.text_.text = var_219_13

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_15 = 8 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 8)

				if (8 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 8)) > 0 and var_219_11 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_10
					end
				end

				arg_216_1.text_.text = var_219_13
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb") ~= 0 then
					local var_219_16 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb") / 1000

					if var_219_16 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_10
					end

					if var_219_12.prefab_name ~= "" and arg_216_1.actors_[var_219_12.prefab_name] ~= nil then
						local var_219_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_12.prefab_name].transform, "story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")

						arg_216_1:RecordAudio("1106103052", var_219_17)
						arg_216_1:RecordAudio("1106103052", var_219_17)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103052", "story_v_side_new_1106103.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_18 = math.max(var_219_11, arg_216_1.talkMaxDuration)

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_18 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_10) / var_219_18

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_10 + var_219_18 and arg_216_1.time_ < var_219_10 + var_219_18 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1106103053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1106103053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1106103054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1061ui_story"]) and arg_220_1.var_.characterEffect1061ui_story == nil then
				arg_220_1.var_.characterEffect1061ui_story = arg_220_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1061ui_story"]) then
				if arg_220_1.var_.characterEffect1061ui_story and not isNil(arg_220_1.actors_["1061ui_story"]) then
					arg_220_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_0)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1061ui_story"]) and arg_220_1.var_.characterEffect1061ui_story then
				arg_220_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_223_1 = 0
			local var_223_2 = 0.325

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_3 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(1106103053).content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 13 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 13)

				if (13 <= 0 and var_223_2 or var_223_2 * (utf8.len(var_223_3) / 13)) > 0 and var_223_2 < var_223_5 then
					arg_220_1.talkMaxDuration = var_223_5

					if var_223_5 + var_223_1 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + var_223_1
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_6 = math.max(var_223_2, arg_220_1.talkMaxDuration)

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_6 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_1) / var_223_6

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_1 + var_223_6 and arg_220_1.time_ < var_223_1 + var_223_6 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1106103054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1106103054
		arg_224_1.duration_ = 6.07

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1106103055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1061ui_story"]) and arg_224_1.var_.characterEffect1061ui_story == nil then
				arg_224_1.var_.characterEffect1061ui_story = arg_224_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1061ui_story"]) then
				if arg_224_1.var_.characterEffect1061ui_story and not isNil(arg_224_1.actors_["1061ui_story"]) then
					arg_224_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1061ui_story"]) and arg_224_1.var_.characterEffect1061ui_story then
				arg_224_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_227_2 = 0
			local var_227_3 = 0.725

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_4 = arg_224_1:GetWordFromCfg(1106103054)
				local var_227_5 = arg_224_1:FormatText(var_227_4.content)

				arg_224_1.text_.text = var_227_5

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_7 = 29 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 29)

				if (29 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 29)) > 0 and var_227_3 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_2
					end
				end

				arg_224_1.text_.text = var_227_5
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb") / 1000

					if var_227_8 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_2
					end

					if var_227_4.prefab_name ~= "" and arg_224_1.actors_[var_227_4.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_4.prefab_name].transform, "story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")

						arg_224_1:RecordAudio("1106103054", var_227_9)
						arg_224_1:RecordAudio("1106103054", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103054", "story_v_side_new_1106103.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_3, arg_224_1.talkMaxDuration)

			if var_227_2 <= arg_224_1.time_ and arg_224_1.time_ < var_227_2 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_2) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_2 + var_227_10 and arg_224_1.time_ < var_227_2 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1106103055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1106103055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1106103056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) and arg_228_1.var_.characterEffect1061ui_story == nil then
				arg_228_1.var_.characterEffect1061ui_story = arg_228_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) then
				if arg_228_1.var_.characterEffect1061ui_story and not isNil(arg_228_1.actors_["1061ui_story"]) then
					arg_228_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_0)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1061ui_story"]) and arg_228_1.var_.characterEffect1061ui_story then
				arg_228_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_231_1 = 0
			local var_231_2 = 0.525

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(1106103055).content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 21 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 21)

				if (21 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 21)) > 0 and var_231_2 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_6 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_6 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_6

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_6 and arg_228_1.time_ < var_231_1 + var_231_6 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1106103056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1106103056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1106103057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.35

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1106103056).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 14 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 14)

				if (14 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 14)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1106103057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1106103057
		arg_236_1.duration_ = 2.7

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1106103058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["1061ui_story"]) and arg_236_1.var_.characterEffect1061ui_story == nil then
				arg_236_1.var_.characterEffect1061ui_story = arg_236_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["1061ui_story"]) then
				if arg_236_1.var_.characterEffect1061ui_story and not isNil(arg_236_1.actors_["1061ui_story"]) then
					arg_236_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1061ui_story"]) and arg_236_1.var_.characterEffect1061ui_story then
				arg_236_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_239_2 = 0
			local var_239_3 = 0.325

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_4 = arg_236_1:GetWordFromCfg(1106103057)
				local var_239_5 = arg_236_1:FormatText(var_239_4.content)

				arg_236_1.text_.text = var_239_5

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 13 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 13)

				if (13 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 13)) > 0 and var_239_3 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_5
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb") / 1000

					if var_239_8 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_2
					end

					if var_239_4.prefab_name ~= "" and arg_236_1.actors_[var_239_4.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_4.prefab_name].transform, "story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")

						arg_236_1:RecordAudio("1106103057", var_239_9)
						arg_236_1:RecordAudio("1106103057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103057", "story_v_side_new_1106103.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_10 and arg_236_1.time_ < var_239_2 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play1106103058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1106103058
		arg_240_1.duration_ = 4.4

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1106103059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_0 = 0
			local var_243_1 = 0.55

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(1106103058)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 22 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 22)

				if (22 <= 0 and var_243_1 or var_243_1 * (utf8.len(var_243_3) / 22)) > 0 and var_243_1 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb") ~= 0 then
					local var_243_6 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb") / 1000

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end

					if var_243_2.prefab_name ~= "" and arg_240_1.actors_[var_243_2.prefab_name] ~= nil then
						local var_243_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_2.prefab_name].transform, "story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")

						arg_240_1:RecordAudio("1106103058", var_243_7)
						arg_240_1:RecordAudio("1106103058", var_243_7)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103058", "story_v_side_new_1106103.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_8 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_8 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_8

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_8 and arg_240_1.time_ < var_243_0 + var_243_8 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1106103059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1106103059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1106103060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1061ui_story"]) and arg_244_1.var_.characterEffect1061ui_story == nil then
				arg_244_1.var_.characterEffect1061ui_story = arg_244_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1061ui_story"]) then
				if arg_244_1.var_.characterEffect1061ui_story and not isNil(arg_244_1.actors_["1061ui_story"]) then
					arg_244_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1061ui_story"]) and arg_244_1.var_.characterEffect1061ui_story then
				arg_244_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.525

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1106103059).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 21 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 21)

				if (21 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 21)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1106103060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1106103060
		arg_248_1.duration_ = 5.27

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1106103061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1061ui_story"]) and arg_248_1.var_.characterEffect1061ui_story == nil then
				arg_248_1.var_.characterEffect1061ui_story = arg_248_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1061ui_story"]) then
				if arg_248_1.var_.characterEffect1061ui_story and not isNil(arg_248_1.actors_["1061ui_story"]) then
					arg_248_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1061ui_story"]) and arg_248_1.var_.characterEffect1061ui_story then
				arg_248_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_251_2 = 0
			local var_251_3 = 0.45

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_4 = arg_248_1:GetWordFromCfg(1106103060)
				local var_251_5 = arg_248_1:FormatText(var_251_4.content)

				arg_248_1.text_.text = var_251_5

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_7 = 18 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 18)

				if (18 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_5) / 18)) > 0 and var_251_3 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_5
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb") / 1000

					if var_251_8 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_2
					end

					if var_251_4.prefab_name ~= "" and arg_248_1.actors_[var_251_4.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_4.prefab_name].transform, "story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")

						arg_248_1:RecordAudio("1106103060", var_251_9)
						arg_248_1:RecordAudio("1106103060", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103060", "story_v_side_new_1106103.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_10 and arg_248_1.time_ < var_251_2 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1106103061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1106103061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1106103062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1061ui_story"]) and arg_252_1.var_.characterEffect1061ui_story == nil then
				arg_252_1.var_.characterEffect1061ui_story = arg_252_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1061ui_story"]) then
				if arg_252_1.var_.characterEffect1061ui_story and not isNil(arg_252_1.actors_["1061ui_story"]) then
					arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1061ui_story"]) and arg_252_1.var_.characterEffect1061ui_story then
				arg_252_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_255_1 = 0
			local var_255_2 = 0.125

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1106103061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 5)

				if (5 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 5)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1106103062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1106103062
		arg_256_1.duration_ = 4.47

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1106103063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) and arg_256_1.var_.characterEffect1061ui_story == nil then
				arg_256_1.var_.characterEffect1061ui_story = arg_256_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) then
				if arg_256_1.var_.characterEffect1061ui_story and not isNil(arg_256_1.actors_["1061ui_story"]) then
					arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1061ui_story"]) and arg_256_1.var_.characterEffect1061ui_story then
				arg_256_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_2")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_259_2 = 0
			local var_259_3 = 0.575

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_4 = arg_256_1:GetWordFromCfg(1106103062)
				local var_259_5 = arg_256_1:FormatText(var_259_4.content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 23 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 23)

				if (23 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_5) / 23)) > 0 and var_259_3 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb") ~= 0 then
					local var_259_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb") / 1000

					if var_259_8 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_8 + var_259_2
					end

					if var_259_4.prefab_name ~= "" and arg_256_1.actors_[var_259_4.prefab_name] ~= nil then
						local var_259_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_4.prefab_name].transform, "story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")

						arg_256_1:RecordAudio("1106103062", var_259_9)
						arg_256_1:RecordAudio("1106103062", var_259_9)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103062", "story_v_side_new_1106103.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_10 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_10 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_10

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_10 and arg_256_1.time_ < var_259_2 + var_259_10 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1106103063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1106103063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1106103064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1061ui_story"]) and arg_260_1.var_.characterEffect1061ui_story == nil then
				arg_260_1.var_.characterEffect1061ui_story = arg_260_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1061ui_story"]) then
				if arg_260_1.var_.characterEffect1061ui_story and not isNil(arg_260_1.actors_["1061ui_story"]) then
					arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1061ui_story"]) and arg_260_1.var_.characterEffect1061ui_story then
				arg_260_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.25

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

				local var_263_3 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1106103063).content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 10 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 10)

				if (10 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 10)) > 0 and var_263_2 < var_263_5 then
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
	Play1106103064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1106103064
		arg_264_1.duration_ = 3.9

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1106103065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1061ui_story"]) and arg_264_1.var_.characterEffect1061ui_story == nil then
				arg_264_1.var_.characterEffect1061ui_story = arg_264_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1061ui_story"]) then
				if arg_264_1.var_.characterEffect1061ui_story and not isNil(arg_264_1.actors_["1061ui_story"]) then
					arg_264_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1061ui_story"]) and arg_264_1.var_.characterEffect1061ui_story then
				arg_264_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_267_2 = 0
			local var_267_3 = 0.4

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_4 = arg_264_1:GetWordFromCfg(1106103064)
				local var_267_5 = arg_264_1:FormatText(var_267_4.content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 16 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 16)

				if (16 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 16)) > 0 and var_267_3 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb") / 1000

					if var_267_8 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_2
					end

					if var_267_4.prefab_name ~= "" and arg_264_1.actors_[var_267_4.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_4.prefab_name].transform, "story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")

						arg_264_1:RecordAudio("1106103064", var_267_9)
						arg_264_1:RecordAudio("1106103064", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103064", "story_v_side_new_1106103.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_10 and arg_264_1.time_ < var_267_2 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1106103065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1106103065
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1106103066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1061ui_story"]) and arg_268_1.var_.characterEffect1061ui_story == nil then
				arg_268_1.var_.characterEffect1061ui_story = arg_268_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1061ui_story"]) then
				if arg_268_1.var_.characterEffect1061ui_story and not isNil(arg_268_1.actors_["1061ui_story"]) then
					arg_268_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1061ui_story"]) and arg_268_1.var_.characterEffect1061ui_story then
				arg_268_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.325

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1106103065).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 13 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 13)

				if (13 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 13)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1106103066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1106103066
		arg_272_1.duration_ = 4.13

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1106103067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1061ui_story"]) and arg_272_1.var_.characterEffect1061ui_story == nil then
				arg_272_1.var_.characterEffect1061ui_story = arg_272_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1061ui_story"]) then
				if arg_272_1.var_.characterEffect1061ui_story and not isNil(arg_272_1.actors_["1061ui_story"]) then
					arg_272_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1061ui_story"]) and arg_272_1.var_.characterEffect1061ui_story then
				arg_272_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_2 = 0
			local var_275_3 = 0.425

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_4 = arg_272_1:GetWordFromCfg(1106103066)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 17 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 17)

				if (17 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 17)) > 0 and var_275_3 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb") / 1000

					if var_275_8 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_2
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")

						arg_272_1:RecordAudio("1106103066", var_275_9)
						arg_272_1:RecordAudio("1106103066", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103066", "story_v_side_new_1106103.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_10 and arg_272_1.time_ < var_275_2 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play1106103067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1106103067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1106103068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1061ui_story"]) and arg_276_1.var_.characterEffect1061ui_story == nil then
				arg_276_1.var_.characterEffect1061ui_story = arg_276_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1061ui_story"]) then
				if arg_276_1.var_.characterEffect1061ui_story and not isNil(arg_276_1.actors_["1061ui_story"]) then
					arg_276_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1061ui_story"]) and arg_276_1.var_.characterEffect1061ui_story then
				arg_276_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.525

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1106103067).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 21 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 21)

				if (21 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 21)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1106103068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1106103068
		arg_280_1.duration_ = 5.5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1106103069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1061ui_story"]) and arg_280_1.var_.characterEffect1061ui_story == nil then
				arg_280_1.var_.characterEffect1061ui_story = arg_280_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1061ui_story"]) then
				if arg_280_1.var_.characterEffect1061ui_story and not isNil(arg_280_1.actors_["1061ui_story"]) then
					arg_280_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1061ui_story"]) and arg_280_1.var_.characterEffect1061ui_story then
				arg_280_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_283_2 = 0
			local var_283_3 = 0.575

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_4 = arg_280_1:GetWordFromCfg(1106103068)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 23 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 23)

				if (23 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 23)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")

						arg_280_1:RecordAudio("1106103068", var_283_9)
						arg_280_1:RecordAudio("1106103068", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103068", "story_v_side_new_1106103.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1106103069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1106103069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1106103070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1061ui_story"]) and arg_284_1.var_.characterEffect1061ui_story == nil then
				arg_284_1.var_.characterEffect1061ui_story = arg_284_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1061ui_story"]) then
				if arg_284_1.var_.characterEffect1061ui_story and not isNil(arg_284_1.actors_["1061ui_story"]) then
					arg_284_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1061ui_story"]) and arg_284_1.var_.characterEffect1061ui_story then
				arg_284_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.5

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(1106103069).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 20 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 20)

				if (20 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 20)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play1106103070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1106103070
		arg_288_1.duration_ = 2

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1106103071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["1061ui_story"]) and arg_288_1.var_.characterEffect1061ui_story == nil then
				arg_288_1.var_.characterEffect1061ui_story = arg_288_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["1061ui_story"]) then
				if arg_288_1.var_.characterEffect1061ui_story and not isNil(arg_288_1.actors_["1061ui_story"]) then
					arg_288_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["1061ui_story"]) and arg_288_1.var_.characterEffect1061ui_story then
				arg_288_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_291_2 = 0
			local var_291_3 = 0.1

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_4 = arg_288_1:GetWordFromCfg(1106103070)
				local var_291_5 = arg_288_1:FormatText(var_291_4.content)

				arg_288_1.text_.text = var_291_5

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_7 = 4 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 4)

				if (4 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_5) / 4)) > 0 and var_291_3 < var_291_7 then
					arg_288_1.talkMaxDuration = var_291_7

					if var_291_7 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_7 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_5
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb") ~= 0 then
					local var_291_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb") / 1000

					if var_291_8 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_8 + var_291_2
					end

					if var_291_4.prefab_name ~= "" and arg_288_1.actors_[var_291_4.prefab_name] ~= nil then
						local var_291_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_4.prefab_name].transform, "story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")

						arg_288_1:RecordAudio("1106103070", var_291_9)
						arg_288_1:RecordAudio("1106103070", var_291_9)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103070", "story_v_side_new_1106103.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_10 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_10 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_10

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_10 and arg_288_1.time_ < var_291_2 + var_291_10 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1106103071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1106103071
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1106103072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1061ui_story"]) and arg_292_1.var_.characterEffect1061ui_story == nil then
				arg_292_1.var_.characterEffect1061ui_story = arg_292_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1061ui_story"]) then
				if arg_292_1.var_.characterEffect1061ui_story and not isNil(arg_292_1.actors_["1061ui_story"]) then
					arg_292_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_0)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1061ui_story"]) and arg_292_1.var_.characterEffect1061ui_story then
				arg_292_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_295_1 = 0
			local var_295_2 = 0.375

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1106103071).content)

				arg_292_1.text_.text = var_295_3

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_5 = 15 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 15)

				if (15 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_3) / 15)) > 0 and var_295_2 < var_295_5 then
					arg_292_1.talkMaxDuration = var_295_5

					if var_295_5 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_3
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_6 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_6 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_6

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_6 and arg_292_1.time_ < var_295_1 + var_295_6 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play1106103072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1106103072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1106103073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1061ui_story = arg_296_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).z)
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles = arg_296_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1061ui_story"].transform.position).z)
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1061ui_story"].transform.localEulerAngles = arg_296_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_299_1 = 0
			local var_299_2 = 0.7

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(1106103072).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)

				if (28 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 28)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1106103073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1106103073
		arg_300_1.duration_ = 7.27

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1106103074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0.7

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_1 = arg_300_1:GetWordFromCfg(1106103073)
				local var_303_2 = arg_300_1:FormatText(var_303_1.content)

				arg_300_1.text_.text = var_303_2

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_4 = 28 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 28)

				if (28 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_2) / 28)) > 0 and var_303_0 < var_303_4 then
					arg_300_1.talkMaxDuration = var_303_4

					if var_303_4 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_4 + 0
					end
				end

				arg_300_1.text_.text = var_303_2
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb") ~= 0 then
					local var_303_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb") / 1000

					if var_303_5 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + 0
					end

					if var_303_1.prefab_name ~= "" and arg_300_1.actors_[var_303_1.prefab_name] ~= nil then
						local var_303_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_1.prefab_name].transform, "story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")

						arg_300_1:RecordAudio("1106103073", var_303_6)
						arg_300_1:RecordAudio("1106103073", var_303_6)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103073", "story_v_side_new_1106103.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_7 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_7

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1106103074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1106103074
		arg_304_1.duration_ = 6.57

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1106103075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0.675

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:GetWordFromCfg(1106103074)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 27 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 27)

				if (27 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 27)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")

						arg_304_1:RecordAudio("1106103074", var_307_6)
						arg_304_1:RecordAudio("1106103074", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103074", "story_v_side_new_1106103.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play1106103075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1106103075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1106103076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.2

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1106103075).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 8 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 8)

				if (8 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 8)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1106103076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1106103076
		arg_312_1.duration_ = 2.23

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1106103077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1061ui_story = arg_312_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).z)
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles = arg_312_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_312_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1061ui_story"].transform.position).z)
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1061ui_story"].transform.localEulerAngles = arg_312_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1061ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1061ui_story == nil then
				arg_312_1.var_.characterEffect1061ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1061ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1061ui_story then
				arg_312_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_315_4 = 0
			local var_315_5 = 0.275

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(1106103076)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 11 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 11)

				if (11 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 11)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")

						arg_312_1:RecordAudio("1106103076", var_315_11)
						arg_312_1:RecordAudio("1106103076", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103076", "story_v_side_new_1106103.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1106103077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1106103077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1106103078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1061ui_story = arg_316_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_319_0 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 then
				arg_316_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_316_1.time_ - 0) / var_319_0)
				arg_316_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).z)
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles = arg_316_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 then
				arg_316_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_316_1.actors_["1061ui_story"].transform.position).z)
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_316_1.actors_["1061ui_story"].transform.localEulerAngles = arg_316_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_319_1 = arg_316_1.actors_["1061ui_story"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1061ui_story == nil then
				arg_316_1.var_.characterEffect1061ui_story = var_319_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_2 and not isNil(var_319_1) then
				if arg_316_1.var_.characterEffect1061ui_story and not isNil(var_319_1) then
					arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_2)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_2 and arg_316_1.time_ < 0 + var_319_2 + arg_319_0 and not isNil(var_319_1) and arg_316_1.var_.characterEffect1061ui_story then
				arg_316_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_319_3 = 0
			local var_319_4 = 1.15

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_3 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_5 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1106103077).content)

				arg_316_1.text_.text = var_319_5

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_7 = 46 <= 0 and var_319_4 or var_319_4 * (utf8.len(var_319_5) / 46)

				if (46 <= 0 and var_319_4 or var_319_4 * (utf8.len(var_319_5) / 46)) > 0 and var_319_4 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_3 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_3
					end
				end

				arg_316_1.text_.text = var_319_5
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_8 = math.max(var_319_4, arg_316_1.talkMaxDuration)

			if var_319_3 <= arg_316_1.time_ and arg_316_1.time_ < var_319_3 + var_319_8 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_3) / var_319_8

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_3 + var_319_8 and arg_316_1.time_ < var_319_3 + var_319_8 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play1106103078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1106103078
		arg_320_1.duration_ = 6.4

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1106103079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_0 = 1.4

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				local var_323_1 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_323_1.a = Mathf.Lerp(1, 0, (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.mask_.color = var_323_1
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				local var_323_2 = Color.New(0.01886791, 0.01886791, 0.01886791)

				arg_320_1.mask_.enabled = false
				var_323_2.a = 0
				arg_320_1.mask_.color = var_323_2
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_3 = 1.4
			local var_323_4 = 0.15

			if 1.4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_3 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_5 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_5:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(1106103078).content)

				arg_320_1.text_.text = var_323_6

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_8 = 6 <= 0 and var_323_4 or var_323_4 * (utf8.len(var_323_6) / 6)

				if (6 <= 0 and var_323_4 or var_323_4 * (utf8.len(var_323_6) / 6)) > 0 and var_323_4 < var_323_8 then
					arg_320_1.talkMaxDuration = var_323_8
					var_323_3 = var_323_3 + 0.3

					if var_323_8 + var_323_3 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_3
					end
				end

				arg_320_1.text_.text = var_323_6
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = var_323_3 + 0.3
			local var_323_10 = math.max(var_323_4, arg_320_1.talkMaxDuration)

			if var_323_3 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_9 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_9) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_9 + var_323_10 and arg_320_1.time_ < var_323_9 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1106103079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1106103079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1106103080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.2

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(1106103079).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 8 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 8)

				if (8 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 8)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1106103080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1106103080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1106103081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_drop", "")
			end

			local var_333_1 = 0
			local var_333_2 = 0.95

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(1106103080).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 38 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 38)

				if (38 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 38)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1106103081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1106103081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1106103082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.125

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(1106103081).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 5 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 5)

				if (5 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 5)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1106103082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1106103082
		arg_338_1.duration_ = 1.3

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1106103083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) and arg_338_1.var_.characterEffect1061ui_story == nil then
				arg_338_1.var_.characterEffect1061ui_story = arg_338_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_0 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) then
				if arg_338_1.var_.characterEffect1061ui_story and not isNil(arg_338_1.actors_["1061ui_story"]) then
					arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1061ui_story"]) and arg_338_1.var_.characterEffect1061ui_story then
				arg_338_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_341_2 = 0
			local var_341_3 = 0.125

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_2 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_4 = arg_338_1:GetWordFromCfg(1106103082)
				local var_341_5 = arg_338_1:FormatText(var_341_4.content)

				arg_338_1.text_.text = var_341_5

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_7 = 5 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 5)

				if (5 <= 0 and var_341_3 or var_341_3 * (utf8.len(var_341_5) / 5)) > 0 and var_341_3 < var_341_7 then
					arg_338_1.talkMaxDuration = var_341_7

					if var_341_7 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_7 + var_341_2
					end
				end

				arg_338_1.text_.text = var_341_5
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb") ~= 0 then
					local var_341_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb") / 1000

					if var_341_8 + var_341_2 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_2
					end

					if var_341_4.prefab_name ~= "" and arg_338_1.actors_[var_341_4.prefab_name] ~= nil then
						local var_341_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_4.prefab_name].transform, "story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")

						arg_338_1:RecordAudio("1106103082", var_341_9)
						arg_338_1:RecordAudio("1106103082", var_341_9)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103082", "story_v_side_new_1106103.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_3, arg_338_1.talkMaxDuration)

			if var_341_2 <= arg_338_1.time_ and arg_338_1.time_ < var_341_2 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_2) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_2 + var_341_10 and arg_338_1.time_ < var_341_2 + var_341_10 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1106103083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1106103083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1106103084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) and arg_342_1.var_.characterEffect1061ui_story == nil then
				arg_342_1.var_.characterEffect1061ui_story = arg_342_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) then
				if arg_342_1.var_.characterEffect1061ui_story and not isNil(arg_342_1.actors_["1061ui_story"]) then
					arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1061ui_story"]) and arg_342_1.var_.characterEffect1061ui_story then
				arg_342_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_345_1 = 0
			local var_345_2 = 0.225

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(1106103083).content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_5 = 9 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 9)

				if (9 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_3) / 9)) > 0 and var_345_2 < var_345_5 then
					arg_342_1.talkMaxDuration = var_345_5

					if var_345_5 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_5 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_6 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_6 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_6

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_6 and arg_342_1.time_ < var_345_1 + var_345_6 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1106103084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1106103084
		arg_346_1.duration_ = 3.17

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1106103085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story == nil then
				arg_346_1.var_.characterEffect1061ui_story = arg_346_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_0 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) then
				if arg_346_1.var_.characterEffect1061ui_story and not isNil(arg_346_1.actors_["1061ui_story"]) then
					arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1061ui_story"]) and arg_346_1.var_.characterEffect1061ui_story then
				arg_346_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_349_2 = 0
			local var_349_3 = 0.3

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_4 = arg_346_1:GetWordFromCfg(1106103084)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 12 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 12)

				if (12 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 12)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")

						arg_346_1:RecordAudio("1106103084", var_349_9)
						arg_346_1:RecordAudio("1106103084", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103084", "story_v_side_new_1106103.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_10 and arg_346_1.time_ < var_349_2 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1106103085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1106103085
		arg_350_1.duration_ = 6.9

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1106103086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0.566666666666667 < arg_350_1.time_ and arg_350_1.time_ <= 0.566666666666667 + arg_353_0 then
				local var_353_0 = arg_350_1.bgs_.ST29

				arg_350_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_353_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_353_1 = var_353_0:GetComponent("SpriteRenderer")

				if var_353_1 and var_353_1.sprite then
					local var_353_2 = 2 * (var_353_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_353_0.transform.localScale = Vector3.New(var_353_2 / var_353_1.sprite.bounds.size.y < var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x and var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x or var_353_2 / var_353_1.sprite.bounds.size.y, var_353_2 / var_353_1.sprite.bounds.size.y < var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x and var_353_2 * manager.ui.mainCameraCom_.aspect / var_353_1.sprite.bounds.size.x or var_353_2 / var_353_1.sprite.bounds.size.y, 0)
				end

				for iter_353_0, iter_353_1 in pairs(arg_350_1.bgs_) do
					if iter_353_0 ~= "ST29" then
						iter_353_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_353_3 = 2.1

			if 2.1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			if arg_350_1.time_ >= var_353_3 + 0.3 and arg_350_1.time_ < var_353_3 + 0.3 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end

			local var_353_4 = 0

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_5 = 0.566666666666667

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_5 then
				local var_353_6 = Color.New(0, 0, 0)

				var_353_6.a = Mathf.Lerp(0, 1, (arg_350_1.time_ - var_353_4) / var_353_5)
				arg_350_1.mask_.color = var_353_6
			end

			if arg_350_1.time_ >= var_353_4 + var_353_5 and arg_350_1.time_ < var_353_4 + var_353_5 + arg_353_0 then
				local var_353_7 = Color.New(0, 0, 0)

				var_353_7.a = 1
				arg_350_1.mask_.color = var_353_7
			end

			local var_353_8 = 0.566666666666667

			if 0.566666666666667 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.mask_.enabled = true
				arg_350_1.mask_.raycastTarget = true

				arg_350_1:SetGaussion(false)
			end

			local var_353_9 = 1.53333333333333

			if var_353_8 <= arg_350_1.time_ and arg_350_1.time_ < var_353_8 + var_353_9 then
				local var_353_10 = Color.New(0, 0, 0)

				var_353_10.a = Mathf.Lerp(1, 0, (arg_350_1.time_ - var_353_8) / var_353_9)
				arg_350_1.mask_.color = var_353_10
			end

			if arg_350_1.time_ >= var_353_8 + var_353_9 and arg_350_1.time_ < var_353_8 + var_353_9 + arg_353_0 then
				local var_353_11 = Color.New(0, 0, 0)

				arg_350_1.mask_.enabled = false
				var_353_11.a = 0
				arg_350_1.mask_.color = var_353_11
			end

			local var_353_12 = arg_350_1.actors_["1061ui_story"]

			if 0.466666666666667 < arg_350_1.time_ and arg_350_1.time_ <= 0.466666666666667 + arg_353_0 and not isNil(var_353_12) and arg_350_1.var_.characterEffect1061ui_story == nil then
				arg_350_1.var_.characterEffect1061ui_story = var_353_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_13 = 0.1

			if 0.466666666666667 <= arg_350_1.time_ and arg_350_1.time_ < 0.466666666666667 + var_353_13 and not isNil(var_353_12) then
				if arg_350_1.var_.characterEffect1061ui_story and not isNil(var_353_12) then
					arg_350_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0.466666666666667) / var_353_13)
				end
			end

			if arg_350_1.time_ >= 0.466666666666667 + var_353_13 and arg_350_1.time_ < 0.466666666666667 + var_353_13 + arg_353_0 and not isNil(var_353_12) and arg_350_1.var_.characterEffect1061ui_story then
				arg_350_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if arg_350_1.frameCnt_ <= 1 then
				arg_350_1.dialog_:SetActive(false)
			end

			local var_353_14 = 1.9
			local var_353_15 = 0.5

			if 1.9 < arg_350_1.time_ and arg_350_1.time_ <= var_353_14 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0

				arg_350_1.dialog_:SetActive(true)

				arg_350_1.dialogCg_.alpha = 0

				local var_353_16 = LeanTween.value(arg_350_1.dialog_, 0, 1, 0.3)

				var_353_16:setOnUpdate(LuaHelper.FloatAction(function(arg_354_0)
					arg_350_1.dialogCg_.alpha = arg_354_0
				end))
				var_353_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_350_1.dialog_)
					var_353_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_350_1.duration_ = arg_350_1.duration_ + 0.3

				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_17 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(1106103085).content)

				arg_350_1.text_.text = var_353_17

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_19 = 20 <= 0 and var_353_15 or var_353_15 * (utf8.len(var_353_17) / 20)

				if (20 <= 0 and var_353_15 or var_353_15 * (utf8.len(var_353_17) / 20)) > 0 and var_353_15 < var_353_19 then
					arg_350_1.talkMaxDuration = var_353_19
					var_353_14 = var_353_14 + 0.3

					if var_353_19 + var_353_14 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_19 + var_353_14
					end
				end

				arg_350_1.text_.text = var_353_17
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_20 = var_353_14 + 0.3
			local var_353_21 = math.max(var_353_15, arg_350_1.talkMaxDuration)

			if var_353_14 + 0.3 <= arg_350_1.time_ and arg_350_1.time_ < var_353_20 + var_353_21 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_20) / var_353_21

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_20 + var_353_21 and arg_350_1.time_ < var_353_20 + var_353_21 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1106103086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1106103086
		arg_356_1.duration_ = 5.27

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1106103087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.625

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:GetWordFromCfg(1106103086)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 25 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 25)

				if (25 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 25)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")

						arg_356_1:RecordAudio("1106103086", var_359_6)
						arg_356_1:RecordAudio("1106103086", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103086", "story_v_side_new_1106103.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1106103087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1106103087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1106103088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0.733333333333333 < arg_360_1.time_ and arg_360_1.time_ <= 0.733333333333333 + arg_363_0 then
				arg_360_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_teacup02", "")
			end

			local var_363_1 = 0
			local var_363_2 = 0.525

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_3 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1106103087).content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_5 = 21 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 21)

				if (21 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_3) / 21)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_6 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_6 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_6

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_6 and arg_360_1.time_ < var_363_1 + var_363_6 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1106103088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1106103088
		arg_364_1.duration_ = 1.9

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1106103089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.2

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:GetWordFromCfg(1106103088)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 8 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 8)

				if (8 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 8)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")

						arg_364_1:RecordAudio("1106103088", var_367_6)
						arg_364_1:RecordAudio("1106103088", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103088", "story_v_side_new_1106103.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1106103089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1106103089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1106103090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.2

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
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

				local var_371_1 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(1106103089).content)

				arg_368_1.text_.text = var_371_1

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_3 = 8 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 8)

				if (8 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_1) / 8)) > 0 and var_371_0 < var_371_3 then
					arg_368_1.talkMaxDuration = var_371_3

					if var_371_3 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_3 + 0
					end
				end

				arg_368_1.text_.text = var_371_1
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_4 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_4

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play1106103090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1106103090
		arg_372_1.duration_ = 5.33

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1106103091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.725

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_1 = arg_372_1:GetWordFromCfg(1106103090)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 29)

				if (29 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 29)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")

						arg_372_1:RecordAudio("1106103090", var_375_6)
						arg_372_1:RecordAudio("1106103090", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103090", "story_v_side_new_1106103.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1106103091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1106103091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1106103092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.525

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

				local var_379_1 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(1106103091).content)

				arg_376_1.text_.text = var_379_1

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_3 = 21 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 21)

				if (21 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_1) / 21)) > 0 and var_379_0 < var_379_3 then
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
	Play1106103092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1106103092
		arg_380_1.duration_ = 3.3

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1106103093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0.375

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_1 = arg_380_1:GetWordFromCfg(1106103092)
				local var_383_2 = arg_380_1:FormatText(var_383_1.content)

				arg_380_1.text_.text = var_383_2

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 15 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 15)

				if (15 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_2) / 15)) > 0 and var_383_0 < var_383_4 then
					arg_380_1.talkMaxDuration = var_383_4

					if var_383_4 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_4 + 0
					end
				end

				arg_380_1.text_.text = var_383_2
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb") ~= 0 then
					local var_383_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb") / 1000

					if var_383_5 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + 0
					end

					if var_383_1.prefab_name ~= "" and arg_380_1.actors_[var_383_1.prefab_name] ~= nil then
						local var_383_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_1.prefab_name].transform, "story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")

						arg_380_1:RecordAudio("1106103092", var_383_6)
						arg_380_1:RecordAudio("1106103092", var_383_6)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103092", "story_v_side_new_1106103.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play1106103093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1106103093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1106103094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.475

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(1106103093).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 19 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 19)

				if (19 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 19)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play1106103094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1106103094
		arg_388_1.duration_ = 5.8

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1106103095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.55

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:GetWordFromCfg(1106103094)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.text_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 22 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 22)

				if (22 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 22)) > 0 and var_391_0 < var_391_4 then
					arg_388_1.talkMaxDuration = var_391_4

					if var_391_4 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_4 + 0
					end
				end

				arg_388_1.text_.text = var_391_2
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")

						arg_388_1:RecordAudio("1106103094", var_391_6)
						arg_388_1:RecordAudio("1106103094", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103094", "story_v_side_new_1106103.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play1106103095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1106103095
		arg_392_1.duration_ = 7.77

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1106103096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.875

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_1 = arg_392_1:GetWordFromCfg(1106103095)
				local var_395_2 = arg_392_1:FormatText(var_395_1.content)

				arg_392_1.text_.text = var_395_2

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 35 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 35)

				if (35 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 35)) > 0 and var_395_0 < var_395_4 then
					arg_392_1.talkMaxDuration = var_395_4

					if var_395_4 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_4 + 0
					end
				end

				arg_392_1.text_.text = var_395_2
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb") ~= 0 then
					local var_395_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb") / 1000

					if var_395_5 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + 0
					end

					if var_395_1.prefab_name ~= "" and arg_392_1.actors_[var_395_1.prefab_name] ~= nil then
						local var_395_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_1.prefab_name].transform, "story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")

						arg_392_1:RecordAudio("1106103095", var_395_6)
						arg_392_1:RecordAudio("1106103095", var_395_6)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103095", "story_v_side_new_1106103.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play1106103096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1106103096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1106103097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.35

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_1 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1106103096).content)

				arg_396_1.text_.text = var_399_1

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_3 = 14 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 14)

				if (14 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_1) / 14)) > 0 and var_399_0 < var_399_3 then
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
	Play1106103097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1106103097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1106103098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.625

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

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(1106103097).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 25 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 25)

				if (25 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 25)) > 0 and var_403_0 < var_403_3 then
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
	Play1106103098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1106103098
		arg_404_1.duration_ = 7.87

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1106103099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.825

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:GetWordFromCfg(1106103098)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 33 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 33)

				if (33 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 33)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")

						arg_404_1:RecordAudio("1106103098", var_407_6)
						arg_404_1:RecordAudio("1106103098", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103098", "story_v_side_new_1106103.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play1106103099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1106103099
		arg_408_1.duration_ = 7.9

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1106103100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.825

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:GetWordFromCfg(1106103099)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 33 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 33)

				if (33 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 33)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")

						arg_408_1:RecordAudio("1106103099", var_411_6)
						arg_408_1:RecordAudio("1106103099", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103099", "story_v_side_new_1106103.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1106103100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1106103100
		arg_412_1.duration_ = 5.5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1106103101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.6

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(1106103100)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 24 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 24)

				if (24 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 24)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")

						arg_412_1:RecordAudio("1106103100", var_415_6)
						arg_412_1:RecordAudio("1106103100", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103100", "story_v_side_new_1106103.awb")
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
	Play1106103101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1106103101
		arg_416_1.duration_ = 2.3

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1106103102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if arg_416_1.actors_["106101ui_story"] == nil and not isNil((Asset.Load("Char/" .. "106101ui_story"))) then
				local var_419_0 = Object.Instantiate(Asset.Load("Char/" .. "106101ui_story"), arg_416_1.stage_.transform)

				var_419_0.name = "106101ui_story"
				var_419_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_416_1.actors_["106101ui_story"] = var_419_0

				local var_419_1 = var_419_0:GetComponentInChildren(typeof(CharacterEffect))

				var_419_1.enabled = true

				local var_419_2 = GameObjectTools.GetOrAddComponent(var_419_0, typeof(DynamicBoneHelper))

				if var_419_2 then
					var_419_2:EnableDynamicBone(false)
				end

				arg_416_1:ShowWeapon(var_419_1.transform, false)

				arg_416_1.var_["106101ui_story" .. "Animator"] = var_419_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_416_1.var_["106101ui_story" .. "Animator"].applyRootMotion = true
				arg_416_1.var_["106101ui_story" .. "LipSync"] = var_419_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_419_3 = arg_416_1.actors_["106101ui_story"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos106101ui_story = var_419_3.localPosition

				arg_416_1:ShowWeapon(arg_416_1.var_["106101ui_story" .. "Animator"].transform, false)
			end

			local var_419_4 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				var_419_3.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_416_1.time_ - 0) / var_419_4)
				var_419_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_419_3.position).x, (manager.ui.mainCamera.transform.position - var_419_3.position).y, (manager.ui.mainCamera.transform.position - var_419_3.position).z)
				var_419_3.localEulerAngles.z = 0
				var_419_3.localEulerAngles.x = 0
				var_419_3.localEulerAngles = var_419_3.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				var_419_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_419_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_419_3.position).x, (manager.ui.mainCamera.transform.position - var_419_3.position).y, (manager.ui.mainCamera.transform.position - var_419_3.position).z)
				var_419_3.localEulerAngles.z = 0
				var_419_3.localEulerAngles.x = 0
				var_419_3.localEulerAngles = var_419_3.localEulerAngles
			end

			local var_419_5 = arg_416_1.actors_["106101ui_story"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.characterEffect106101ui_story == nil then
				arg_416_1.var_.characterEffect106101ui_story = var_419_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_6 = 0.200000002980232

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_6 and not isNil(var_419_5) then
				if arg_416_1.var_.characterEffect106101ui_story and not isNil(var_419_5) then
					arg_416_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= 0 + var_419_6 and arg_416_1.time_ < 0 + var_419_6 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.characterEffect106101ui_story then
				arg_416_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_1")
			end

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_419_8 = arg_416_1.actors_["1061ui_story"].transform

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos1061ui_story = var_419_8.localPosition

				arg_416_1:ShowWeapon(arg_416_1.var_["1061ui_story" .. "Animator"].transform, false)
			end

			local var_419_9 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_9 then
				var_419_8.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_416_1.time_ - 0) / var_419_9)
				var_419_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_419_8.position).x, (manager.ui.mainCamera.transform.position - var_419_8.position).y, (manager.ui.mainCamera.transform.position - var_419_8.position).z)
				var_419_8.localEulerAngles.z = 0
				var_419_8.localEulerAngles.x = 0
				var_419_8.localEulerAngles = var_419_8.localEulerAngles
			end

			if arg_416_1.time_ >= 0 + var_419_9 and arg_416_1.time_ < 0 + var_419_9 + arg_419_0 then
				var_419_8.localPosition = Vector3.New(0, 100, 0)
				var_419_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_419_8.position).x, (manager.ui.mainCamera.transform.position - var_419_8.position).y, (manager.ui.mainCamera.transform.position - var_419_8.position).z)
				var_419_8.localEulerAngles.z = 0
				var_419_8.localEulerAngles.x = 0
				var_419_8.localEulerAngles = var_419_8.localEulerAngles
			end

			local var_419_10 = 0
			local var_419_11 = 0.275

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_12 = arg_416_1:GetWordFromCfg(1106103101)
				local var_419_13 = arg_416_1:FormatText(var_419_12.content)

				arg_416_1.text_.text = var_419_13

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_15 = 11 <= 0 and var_419_11 or var_419_11 * (utf8.len(var_419_13) / 11)

				if (11 <= 0 and var_419_11 or var_419_11 * (utf8.len(var_419_13) / 11)) > 0 and var_419_11 < var_419_15 then
					arg_416_1.talkMaxDuration = var_419_15

					if var_419_15 + var_419_10 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_15 + var_419_10
					end
				end

				arg_416_1.text_.text = var_419_13
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb") ~= 0 then
					local var_419_16 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb") / 1000

					if var_419_16 + var_419_10 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_16 + var_419_10
					end

					if var_419_12.prefab_name ~= "" and arg_416_1.actors_[var_419_12.prefab_name] ~= nil then
						local var_419_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_12.prefab_name].transform, "story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")

						arg_416_1:RecordAudio("1106103101", var_419_17)
						arg_416_1:RecordAudio("1106103101", var_419_17)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103101", "story_v_side_new_1106103.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_18 = math.max(var_419_11, arg_416_1.talkMaxDuration)

			if var_419_10 <= arg_416_1.time_ and arg_416_1.time_ < var_419_10 + var_419_18 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_10) / var_419_18

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_10 + var_419_18 and arg_416_1.time_ < var_419_10 + var_419_18 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_416_1:InitPlayNodeList()
	end,
	Play1106103102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1106103102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1106103103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos106101ui_story = arg_420_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).z)
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles = arg_420_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["106101ui_story"].transform.position).z)
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["106101ui_story"].transform.localEulerAngles = arg_420_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["106101ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect106101ui_story == nil then
				arg_420_1.var_.characterEffect106101ui_story = var_423_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 and not isNil(var_423_1) then
				if arg_420_1.var_.characterEffect106101ui_story and not isNil(var_423_1) then
					arg_420_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_420_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_420_1.time_ - 0) / var_423_2)
				end
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect106101ui_story then
				arg_420_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_420_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_423_3 = 0
			local var_423_4 = 1.1

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_3 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, false)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_5 = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(1106103102).content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 44 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 44)

				if (44 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_5) / 44)) > 0 and var_423_4 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_3
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_8 = math.max(var_423_4, arg_420_1.talkMaxDuration)

			if var_423_3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_3 + var_423_8 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_3) / var_423_8

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_3 + var_423_8 and arg_420_1.time_ < var_423_3 + var_423_8 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1106103103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1106103103
		arg_424_1.duration_ = 6.17

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1106103104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.65

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[1357].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_1 = arg_424_1:GetWordFromCfg(1106103103)
				local var_427_2 = arg_424_1:FormatText(var_427_1.content)

				arg_424_1.text_.text = var_427_2

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 26 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 26)

				if (26 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 26)) > 0 and var_427_0 < var_427_4 then
					arg_424_1.talkMaxDuration = var_427_4

					if var_427_4 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_4 + 0
					end
				end

				arg_424_1.text_.text = var_427_2
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb") ~= 0 then
					local var_427_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb") / 1000

					if var_427_5 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + 0
					end

					if var_427_1.prefab_name ~= "" and arg_424_1.actors_[var_427_1.prefab_name] ~= nil then
						local var_427_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_1.prefab_name].transform, "story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")

						arg_424_1:RecordAudio("1106103103", var_427_6)
						arg_424_1:RecordAudio("1106103103", var_427_6)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103103", "story_v_side_new_1106103.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1106103104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1106103104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1106103105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0.0666666666666667 < arg_428_1.time_ and arg_428_1.time_ <= 0.0666666666666667 + arg_431_0 then
				arg_428_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_door", "")
			end

			local var_431_1 = 0
			local var_431_2 = 0.875

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_3 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(1106103104).content)

				arg_428_1.text_.text = var_431_3

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_5 = 35 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_3) / 35)

				if (35 <= 0 and var_431_2 or var_431_2 * (utf8.len(var_431_3) / 35)) > 0 and var_431_2 < var_431_5 then
					arg_428_1.talkMaxDuration = var_431_5

					if var_431_5 + var_431_1 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + var_431_1
					end
				end

				arg_428_1.text_.text = var_431_3
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_6 = math.max(var_431_2, arg_428_1.talkMaxDuration)

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_6 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_1) / var_431_6

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_1 + var_431_6 and arg_428_1.time_ < var_431_1 + var_431_6 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1106103105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1106103105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1106103106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.3

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(1106103105).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 12 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 12)

				if (12 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 12)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1106103106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1106103106
		arg_436_1.duration_ = 2.83

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1106103107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.4

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[1358].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow1095")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_1 = arg_436_1:GetWordFromCfg(1106103106)
				local var_439_2 = arg_436_1:FormatText(var_439_1.content)

				arg_436_1.text_.text = var_439_2

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 16 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 16)

				if (16 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 16)) > 0 and var_439_0 < var_439_4 then
					arg_436_1.talkMaxDuration = var_439_4

					if var_439_4 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_4 + 0
					end
				end

				arg_436_1.text_.text = var_439_2
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb") ~= 0 then
					local var_439_5 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb") / 1000

					if var_439_5 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + 0
					end

					if var_439_1.prefab_name ~= "" and arg_436_1.actors_[var_439_1.prefab_name] ~= nil then
						local var_439_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_1.prefab_name].transform, "story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")

						arg_436_1:RecordAudio("1106103106", var_439_6)
						arg_436_1:RecordAudio("1106103106", var_439_6)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103106", "story_v_side_new_1106103.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1106103107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1106103107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1106103108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos106101ui_story = arg_440_1.actors_["106101ui_story"].transform.localPosition

				arg_440_1:ShowWeapon(arg_440_1.var_["106101ui_story" .. "Animator"].transform, false)
			end

			local var_443_0 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 then
				arg_440_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_440_1.time_ - 0) / var_443_0)
				arg_440_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).z)
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles = arg_440_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 then
				arg_440_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_440_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_440_1.actors_["106101ui_story"].transform.position).z)
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_440_1.actors_["106101ui_story"].transform.localEulerAngles = arg_440_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_443_1 = 0
			local var_443_2 = 0.7

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_3 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1106103107).content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 28 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 28)

				if (28 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 28)) > 0 and var_443_2 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_1 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_1
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_6 = math.max(var_443_2, arg_440_1.talkMaxDuration)

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_6 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_1) / var_443_6

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_1 + var_443_6 and arg_440_1.time_ < var_443_1 + var_443_6 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1106103108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1106103108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1106103109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 1.55

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(1106103108).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 62 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 62)

				if (62 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 62)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1106103109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1106103109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1106103110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 1.125

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_1 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(1106103109).content)

				arg_448_1.text_.text = var_451_1

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_3 = 45 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 45)

				if (45 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 45)) > 0 and var_451_0 < var_451_3 then
					arg_448_1.talkMaxDuration = var_451_3

					if var_451_3 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_3 + 0
					end
				end

				arg_448_1.text_.text = var_451_1
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_4 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_4

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1106103110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1106103110
		arg_452_1.duration_ = 3.47

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1106103111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["106101ui_story"]) and arg_452_1.var_.characterEffect106101ui_story == nil then
				arg_452_1.var_.characterEffect106101ui_story = arg_452_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["106101ui_story"]) then
				if arg_452_1.var_.characterEffect106101ui_story and not isNil(arg_452_1.actors_["106101ui_story"]) then
					arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["106101ui_story"]) and arg_452_1.var_.characterEffect106101ui_story then
				arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			local var_455_2 = arg_452_1.actors_["106101ui_story"].transform

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos106101ui_story = var_455_2.localPosition

				arg_452_1:ShowWeapon(arg_452_1.var_["106101ui_story" .. "Animator"].transform, false)
			end

			local var_455_3 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_3 then
				var_455_2.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_452_1.time_ - 0) / var_455_3)
				var_455_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_2.position).x, (manager.ui.mainCamera.transform.position - var_455_2.position).y, (manager.ui.mainCamera.transform.position - var_455_2.position).z)
				var_455_2.localEulerAngles.z = 0
				var_455_2.localEulerAngles.x = 0
				var_455_2.localEulerAngles = var_455_2.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_3 and arg_452_1.time_ < 0 + var_455_3 + arg_455_0 then
				var_455_2.localPosition = Vector3.New(0, -1.18, -6.15)
				var_455_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_455_2.position).x, (manager.ui.mainCamera.transform.position - var_455_2.position).y, (manager.ui.mainCamera.transform.position - var_455_2.position).z)
				var_455_2.localEulerAngles.z = 0
				var_455_2.localEulerAngles.x = 0
				var_455_2.localEulerAngles = var_455_2.localEulerAngles
			end

			local var_455_4 = arg_452_1.actors_["106101ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect106101ui_story == nil then
				arg_452_1.var_.characterEffect106101ui_story = var_455_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_5 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_5 and not isNil(var_455_4) then
				if arg_452_1.var_.characterEffect106101ui_story and not isNil(var_455_4) then
					arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_5 and arg_452_1.time_ < 0 + var_455_5 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect106101ui_story then
				arg_452_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action494")
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_455_7 = 0
			local var_455_8 = 0.325

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_7 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_9 = arg_452_1:GetWordFromCfg(1106103110)
				local var_455_10 = arg_452_1:FormatText(var_455_9.content)

				arg_452_1.text_.text = var_455_10

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_12 = 13 <= 0 and var_455_8 or var_455_8 * (utf8.len(var_455_10) / 13)

				if (13 <= 0 and var_455_8 or var_455_8 * (utf8.len(var_455_10) / 13)) > 0 and var_455_8 < var_455_12 then
					arg_452_1.talkMaxDuration = var_455_12

					if var_455_12 + var_455_7 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_12 + var_455_7
					end
				end

				arg_452_1.text_.text = var_455_10
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb") ~= 0 then
					local var_455_13 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb") / 1000

					if var_455_13 + var_455_7 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_13 + var_455_7
					end

					if var_455_9.prefab_name ~= "" and arg_452_1.actors_[var_455_9.prefab_name] ~= nil then
						local var_455_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_9.prefab_name].transform, "story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")

						arg_452_1:RecordAudio("1106103110", var_455_14)
						arg_452_1:RecordAudio("1106103110", var_455_14)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103110", "story_v_side_new_1106103.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_15 = math.max(var_455_8, arg_452_1.talkMaxDuration)

			if var_455_7 <= arg_452_1.time_ and arg_452_1.time_ < var_455_7 + var_455_15 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_7) / var_455_15

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_7 + var_455_15 and arg_452_1.time_ < var_455_7 + var_455_15 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1106103111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106103111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106103112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["106101ui_story"]) and arg_456_1.var_.characterEffect106101ui_story == nil then
				arg_456_1.var_.characterEffect106101ui_story = arg_456_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_0 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["106101ui_story"]) then
				if arg_456_1.var_.characterEffect106101ui_story and not isNil(arg_456_1.actors_["106101ui_story"]) then
					arg_456_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_456_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_456_1.time_ - 0) / var_459_0)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["106101ui_story"]) and arg_456_1.var_.characterEffect106101ui_story then
				arg_456_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_456_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_459_1 = 0
			local var_459_2 = 1.15

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1106103111).content)

				arg_456_1.text_.text = var_459_3

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 46 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 46)

				if (46 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 46)) > 0 and var_459_2 < var_459_5 then
					arg_456_1.talkMaxDuration = var_459_5

					if var_459_5 + var_459_1 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + var_459_1
					end
				end

				arg_456_1.text_.text = var_459_3
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_6 = math.max(var_459_2, arg_456_1.talkMaxDuration)

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_6 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_1) / var_459_6

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_1 + var_459_6 and arg_456_1.time_ < var_459_1 + var_459_6 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106103112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106103112
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106103113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos106101ui_story = arg_460_1.actors_["106101ui_story"].transform.localPosition

				arg_460_1:ShowWeapon(arg_460_1.var_["106101ui_story" .. "Animator"].transform, false)
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).z)
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles = arg_460_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_460_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["106101ui_story"].transform.position).z)
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["106101ui_story"].transform.localEulerAngles = arg_460_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_463_1 = 0
			local var_463_2 = 0.475

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(1106103112).content)

				arg_460_1.text_.text = var_463_3

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 19 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 19)

				if (19 <= 0 and var_463_2 or var_463_2 * (utf8.len(var_463_3) / 19)) > 0 and var_463_2 < var_463_5 then
					arg_460_1.talkMaxDuration = var_463_5

					if var_463_5 + var_463_1 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + var_463_1
					end
				end

				arg_460_1.text_.text = var_463_3
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_6 = math.max(var_463_2, arg_460_1.talkMaxDuration)

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_6 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_1) / var_463_6

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_1 + var_463_6 and arg_460_1.time_ < var_463_1 + var_463_6 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106103113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106103113
		arg_464_1.duration_ = 6.52

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1106103114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 5.51846216336447 < arg_464_1.time_ and arg_464_1.time_ <= 5.51846216336447 + arg_467_0 then
				arg_464_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_footstep01", "")
			end

			local var_467_1 = 0
			local var_467_2 = 1.45

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(1106103113).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 58 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 58)

				if (58 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 58)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1106103114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1106103114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1106103115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.2

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(1106103114).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 8 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 8)

				if (8 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 8)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1106103115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1106103115
		arg_472_1.duration_ = 3.7

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1106103116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos106101ui_story = arg_472_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_475_0 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_472_1.time_ - 0) / var_475_0)
				arg_472_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).z)
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles = arg_472_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_472_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["106101ui_story"].transform.position).z)
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["106101ui_story"].transform.localEulerAngles = arg_472_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_475_1 = arg_472_1.actors_["106101ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect106101ui_story == nil then
				arg_472_1.var_.characterEffect106101ui_story = var_475_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_2 and not isNil(var_475_1) then
				if arg_472_1.var_.characterEffect106101ui_story and not isNil(var_475_1) then
					arg_472_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_2 and arg_472_1.time_ < 0 + var_475_2 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect106101ui_story then
				arg_472_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action447")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_475_4 = 0
			local var_475_5 = 0.3

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_6 = arg_472_1:GetWordFromCfg(1106103115)
				local var_475_7 = arg_472_1:FormatText(var_475_6.content)

				arg_472_1.text_.text = var_475_7

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_9 = 12 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 12)

				if (12 <= 0 and var_475_5 or var_475_5 * (utf8.len(var_475_7) / 12)) > 0 and var_475_5 < var_475_9 then
					arg_472_1.talkMaxDuration = var_475_9

					if var_475_9 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_9 + var_475_4
					end
				end

				arg_472_1.text_.text = var_475_7
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb") ~= 0 then
					local var_475_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb") / 1000

					if var_475_10 + var_475_4 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_10 + var_475_4
					end

					if var_475_6.prefab_name ~= "" and arg_472_1.actors_[var_475_6.prefab_name] ~= nil then
						local var_475_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_6.prefab_name].transform, "story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")

						arg_472_1:RecordAudio("1106103115", var_475_11)
						arg_472_1:RecordAudio("1106103115", var_475_11)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103115", "story_v_side_new_1106103.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_12 = math.max(var_475_5, arg_472_1.talkMaxDuration)

			if var_475_4 <= arg_472_1.time_ and arg_472_1.time_ < var_475_4 + var_475_12 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_4) / var_475_12

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_4 + var_475_12 and arg_472_1.time_ < var_475_4 + var_475_12 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1106103116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1106103116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1106103117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["106101ui_story"]) and arg_476_1.var_.characterEffect106101ui_story == nil then
				arg_476_1.var_.characterEffect106101ui_story = arg_476_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["106101ui_story"]) then
				if arg_476_1.var_.characterEffect106101ui_story and not isNil(arg_476_1.actors_["106101ui_story"]) then
					arg_476_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_476_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["106101ui_story"]) and arg_476_1.var_.characterEffect106101ui_story then
				arg_476_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_476_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_479_1 = 0
			local var_479_2 = 0.55

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(1106103116).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 22 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 22)

				if (22 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 22)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1106103117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1106103117
		arg_480_1.duration_ = 4.07

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1106103118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos106101ui_story = arg_480_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).z)
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles = arg_480_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_480_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["106101ui_story"].transform.position).z)
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["106101ui_story"].transform.localEulerAngles = arg_480_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_483_1 = arg_480_1.actors_["106101ui_story"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect106101ui_story == nil then
				arg_480_1.var_.characterEffect106101ui_story = var_483_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_2 and not isNil(var_483_1) then
				if arg_480_1.var_.characterEffect106101ui_story and not isNil(var_483_1) then
					arg_480_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_480_1.time_ >= 0 + var_483_2 and arg_480_1.time_ < 0 + var_483_2 + arg_483_0 and not isNil(var_483_1) and arg_480_1.var_.characterEffect106101ui_story then
				arg_480_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action472")
			end

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_483_4 = 0
			local var_483_5 = 0.5

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_4 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_6 = arg_480_1:GetWordFromCfg(1106103117)
				local var_483_7 = arg_480_1:FormatText(var_483_6.content)

				arg_480_1.text_.text = var_483_7

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_9 = 20 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 20)

				if (20 <= 0 and var_483_5 or var_483_5 * (utf8.len(var_483_7) / 20)) > 0 and var_483_5 < var_483_9 then
					arg_480_1.talkMaxDuration = var_483_9

					if var_483_9 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_9 + var_483_4
					end
				end

				arg_480_1.text_.text = var_483_7
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb") ~= 0 then
					local var_483_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb") / 1000

					if var_483_10 + var_483_4 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_4
					end

					if var_483_6.prefab_name ~= "" and arg_480_1.actors_[var_483_6.prefab_name] ~= nil then
						local var_483_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_6.prefab_name].transform, "story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")

						arg_480_1:RecordAudio("1106103117", var_483_11)
						arg_480_1:RecordAudio("1106103117", var_483_11)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103117", "story_v_side_new_1106103.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_12 = math.max(var_483_5, arg_480_1.talkMaxDuration)

			if var_483_4 <= arg_480_1.time_ and arg_480_1.time_ < var_483_4 + var_483_12 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_4) / var_483_12

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_4 + var_483_12 and arg_480_1.time_ < var_483_4 + var_483_12 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play1106103118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1106103118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1106103119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["106101ui_story"]) and arg_484_1.var_.characterEffect106101ui_story == nil then
				arg_484_1.var_.characterEffect106101ui_story = arg_484_1.actors_["106101ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_0 = 0.200000002980232

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["106101ui_story"]) then
				if arg_484_1.var_.characterEffect106101ui_story and not isNil(arg_484_1.actors_["106101ui_story"]) then
					arg_484_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_484_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_484_1.time_ - 0) / var_487_0)
				end
			end

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["106101ui_story"]) and arg_484_1.var_.characterEffect106101ui_story then
				arg_484_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_484_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_487_1 = 0
			local var_487_2 = 0.725

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_3 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(1106103118).content)

				arg_484_1.text_.text = var_487_3

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_5 = 29 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 29)

				if (29 <= 0 and var_487_2 or var_487_2 * (utf8.len(var_487_3) / 29)) > 0 and var_487_2 < var_487_5 then
					arg_484_1.talkMaxDuration = var_487_5

					if var_487_5 + var_487_1 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_5 + var_487_1
					end
				end

				arg_484_1.text_.text = var_487_3
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_6 = math.max(var_487_2, arg_484_1.talkMaxDuration)

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_6 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_1) / var_487_6

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_1 + var_487_6 and arg_484_1.time_ < var_487_1 + var_487_6 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1106103119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1106103119
		arg_488_1.duration_ = 5.5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1106103120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos106101ui_story = arg_488_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_491_0 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				arg_488_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).z)
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles = arg_488_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				arg_488_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_488_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_488_1.actors_["106101ui_story"].transform.position).z)
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_488_1.actors_["106101ui_story"].transform.localEulerAngles = arg_488_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_491_1 = arg_488_1.actors_["106101ui_story"]

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect106101ui_story == nil then
				arg_488_1.var_.characterEffect106101ui_story = var_491_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_2 and not isNil(var_491_1) then
				if arg_488_1.var_.characterEffect106101ui_story and not isNil(var_491_1) then
					arg_488_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_488_1.time_ >= 0 + var_491_2 and arg_488_1.time_ < 0 + var_491_2 + arg_491_0 and not isNil(var_491_1) and arg_488_1.var_.characterEffect106101ui_story then
				arg_488_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action426")
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_491_4 = 0
			local var_491_5 = 0.55

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_4 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_6 = arg_488_1:GetWordFromCfg(1106103119)
				local var_491_7 = arg_488_1:FormatText(var_491_6.content)

				arg_488_1.text_.text = var_491_7

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_9 = 22 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 22)

				if (22 <= 0 and var_491_5 or var_491_5 * (utf8.len(var_491_7) / 22)) > 0 and var_491_5 < var_491_9 then
					arg_488_1.talkMaxDuration = var_491_9

					if var_491_9 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_9 + var_491_4
					end
				end

				arg_488_1.text_.text = var_491_7
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb") ~= 0 then
					local var_491_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb") / 1000

					if var_491_10 + var_491_4 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_4
					end

					if var_491_6.prefab_name ~= "" and arg_488_1.actors_[var_491_6.prefab_name] ~= nil then
						local var_491_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_6.prefab_name].transform, "story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")

						arg_488_1:RecordAudio("1106103119", var_491_11)
						arg_488_1:RecordAudio("1106103119", var_491_11)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103119", "story_v_side_new_1106103.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_12 = math.max(var_491_5, arg_488_1.talkMaxDuration)

			if var_491_4 <= arg_488_1.time_ and arg_488_1.time_ < var_491_4 + var_491_12 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_4) / var_491_12

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_4 + var_491_12 and arg_488_1.time_ < var_491_4 + var_491_12 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play1106103120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1106103120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1106103121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos106101ui_story = arg_492_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_495_0 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 then
				arg_492_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_492_1.time_ - 0) / var_495_0)
				arg_492_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).z)
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles = arg_492_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 then
				arg_492_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_492_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["106101ui_story"].transform.position).z)
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["106101ui_story"].transform.localEulerAngles = arg_492_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_495_1 = arg_492_1.actors_["106101ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect106101ui_story == nil then
				arg_492_1.var_.characterEffect106101ui_story = var_495_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_2 and not isNil(var_495_1) then
				if arg_492_1.var_.characterEffect106101ui_story and not isNil(var_495_1) then
					arg_492_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_492_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_2)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_2 and arg_492_1.time_ < 0 + var_495_2 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect106101ui_story then
				arg_492_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_492_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_495_3 = 0
			local var_495_4 = 0.775

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_3 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_5 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(1106103120).content)

				arg_492_1.text_.text = var_495_5

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_7 = 31 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 31)

				if (31 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 31)) > 0 and var_495_4 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_3 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_3
					end
				end

				arg_492_1.text_.text = var_495_5
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_8 = math.max(var_495_4, arg_492_1.talkMaxDuration)

			if var_495_3 <= arg_492_1.time_ and arg_492_1.time_ < var_495_3 + var_495_8 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_3) / var_495_8

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_3 + var_495_8 and arg_492_1.time_ < var_495_3 + var_495_8 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1106103121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1106103121
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1106103122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.375

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(1106103121).content)

				arg_496_1.text_.text = var_499_1

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_3 = 15 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 15)

				if (15 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_1) / 15)) > 0 and var_499_0 < var_499_3 then
					arg_496_1.talkMaxDuration = var_499_3

					if var_499_3 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_3 + 0
					end
				end

				arg_496_1.text_.text = var_499_1
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_4 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_4 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_4

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_4 and arg_496_1.time_ < 0 + var_499_4 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1106103122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1106103122
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1106103123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.3

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(1106103122).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 12 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 12)

				if (12 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 12)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1106103123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1106103123
		arg_504_1.duration_ = 3.63

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1106103124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.var_.moveOldPos106101ui_story = arg_504_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_507_0 = 0.001

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_0 then
				arg_504_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_504_1.var_.moveOldPos106101ui_story, Vector3.New(0, -1.18, -6.15), (arg_504_1.time_ - 0) / var_507_0)
				arg_504_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).z)
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles = arg_504_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_504_1.time_ >= 0 + var_507_0 and arg_504_1.time_ < 0 + var_507_0 + arg_507_0 then
				arg_504_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, -1.18, -6.15)
				arg_504_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_504_1.actors_["106101ui_story"].transform.position).z)
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_504_1.actors_["106101ui_story"].transform.localEulerAngles = arg_504_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_507_1 = arg_504_1.actors_["106101ui_story"]

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 and not isNil(var_507_1) and arg_504_1.var_.characterEffect106101ui_story == nil then
				arg_504_1.var_.characterEffect106101ui_story = var_507_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_507_2 = 0.200000002980232

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_2 and not isNil(var_507_1) then
				if arg_504_1.var_.characterEffect106101ui_story and not isNil(var_507_1) then
					arg_504_1.var_.characterEffect106101ui_story.fillFlat = false
				end
			end

			if arg_504_1.time_ >= 0 + var_507_2 and arg_504_1.time_ < 0 + var_507_2 + arg_507_0 and not isNil(var_507_1) and arg_504_1.var_.characterEffect106101ui_story then
				arg_504_1.var_.characterEffect106101ui_story.fillFlat = false
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action6_2")
			end

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_507_4 = 0
			local var_507_5 = 0.45

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_4 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_6 = arg_504_1:GetWordFromCfg(1106103123)
				local var_507_7 = arg_504_1:FormatText(var_507_6.content)

				arg_504_1.text_.text = var_507_7

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_9 = 18 <= 0 and var_507_5 or var_507_5 * (utf8.len(var_507_7) / 18)

				if (18 <= 0 and var_507_5 or var_507_5 * (utf8.len(var_507_7) / 18)) > 0 and var_507_5 < var_507_9 then
					arg_504_1.talkMaxDuration = var_507_9

					if var_507_9 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_9 + var_507_4
					end
				end

				arg_504_1.text_.text = var_507_7
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb") ~= 0 then
					local var_507_10 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb") / 1000

					if var_507_10 + var_507_4 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_10 + var_507_4
					end

					if var_507_6.prefab_name ~= "" and arg_504_1.actors_[var_507_6.prefab_name] ~= nil then
						local var_507_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_6.prefab_name].transform, "story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")

						arg_504_1:RecordAudio("1106103123", var_507_11)
						arg_504_1:RecordAudio("1106103123", var_507_11)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103123", "story_v_side_new_1106103.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_12 = math.max(var_507_5, arg_504_1.talkMaxDuration)

			if var_507_4 <= arg_504_1.time_ and arg_504_1.time_ < var_507_4 + var_507_12 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_4) / var_507_12

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_4 + var_507_12 and arg_504_1.time_ < var_507_4 + var_507_12 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_504_1:InitPlayNodeList()
	end,
	Play1106103124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1106103124
		arg_508_1.duration_ = 2

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1106103125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("106101ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva", "EmotionTimelineAnimator")
			end

			local var_511_0 = 0
			local var_511_1 = 0.175

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_2 = arg_508_1:GetWordFromCfg(1106103124)
				local var_511_3 = arg_508_1:FormatText(var_511_2.content)

				arg_508_1.text_.text = var_511_3

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 7 <= 0 and var_511_1 or var_511_1 * (utf8.len(var_511_3) / 7)

				if (7 <= 0 and var_511_1 or var_511_1 * (utf8.len(var_511_3) / 7)) > 0 and var_511_1 < var_511_5 then
					arg_508_1.talkMaxDuration = var_511_5

					if var_511_5 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_5 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_3
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb") ~= 0 then
					local var_511_6 = manager.audio:GetVoiceLength("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb") / 1000

					if var_511_6 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_6 + var_511_0
					end

					if var_511_2.prefab_name ~= "" and arg_508_1.actors_[var_511_2.prefab_name] ~= nil then
						local var_511_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_2.prefab_name].transform, "story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")

						arg_508_1:RecordAudio("1106103124", var_511_7)
						arg_508_1:RecordAudio("1106103124", var_511_7)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_new_1106103", "1106103124", "story_v_side_new_1106103.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_8 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_8 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_8

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_8 and arg_508_1.time_ < var_511_0 + var_511_8 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play1106103125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1106103125
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
			arg_512_1.auto_ = false
		end

		function arg_512_1.playNext_(arg_514_0)
			arg_512_1.onStoryFinished_()
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 then
				arg_512_1.var_.moveOldPos106101ui_story = arg_512_1.actors_["106101ui_story"].transform.localPosition
			end

			local var_515_0 = 0.001

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 then
				arg_512_1.actors_["106101ui_story"].transform.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPos106101ui_story, Vector3.New(0, 100, 0), (arg_512_1.time_ - 0) / var_515_0)
				arg_512_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).z)
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles = arg_512_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 then
				arg_512_1.actors_["106101ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_512_1.actors_["106101ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_512_1.actors_["106101ui_story"].transform.position).z)
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles.z = 0
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles.x = 0
				arg_512_1.actors_["106101ui_story"].transform.localEulerAngles = arg_512_1.actors_["106101ui_story"].transform.localEulerAngles
			end

			local var_515_1 = arg_512_1.actors_["106101ui_story"]

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(var_515_1) and arg_512_1.var_.characterEffect106101ui_story == nil then
				arg_512_1.var_.characterEffect106101ui_story = var_515_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_2 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_2 and not isNil(var_515_1) then
				if arg_512_1.var_.characterEffect106101ui_story and not isNil(var_515_1) then
					arg_512_1.var_.characterEffect106101ui_story.fillFlat = true
					arg_512_1.var_.characterEffect106101ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_2)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_2 and arg_512_1.time_ < 0 + var_515_2 + arg_515_0 and not isNil(var_515_1) and arg_512_1.var_.characterEffect106101ui_story then
				arg_512_1.var_.characterEffect106101ui_story.fillFlat = true
				arg_512_1.var_.characterEffect106101ui_story.fillRatio = 0.5
			end

			local var_515_3 = 0
			local var_515_4 = 0.725

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_3 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, false)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_5 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(1106103125).content)

				arg_512_1.text_.text = var_515_5

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_7 = 29 <= 0 and var_515_4 or var_515_4 * (utf8.len(var_515_5) / 29)

				if (29 <= 0 and var_515_4 or var_515_4 * (utf8.len(var_515_5) / 29)) > 0 and var_515_4 < var_515_7 then
					arg_512_1.talkMaxDuration = var_515_7

					if var_515_7 + var_515_3 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_7 + var_515_3
					end
				end

				arg_512_1.text_.text = var_515_5
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_8 = math.max(var_515_4, arg_512_1.talkMaxDuration)

			if var_515_3 <= arg_512_1.time_ and arg_512_1.time_ < var_515_3 + var_515_8 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_3) / var_515_8

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_3 + var_515_8 and arg_512_1.time_ < var_515_3 + var_515_8 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106101ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST47"
	},
	voices = {
		"story_v_side_new_1106103.awb"
	}
}
